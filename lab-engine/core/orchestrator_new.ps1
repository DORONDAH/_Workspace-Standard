# Orchestrator (Real Implementation)

param (
    [string]$TaskContractPath
)

# Define paths
$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ProjectRoot = Split-Path -Parent $ScriptRoot
$ProjectTruthPath = Join-Path $ProjectRoot 'projects/workspace-standard/PROJECT-TRUTH.md'
$ProjectStatePath = Join-Path $ProjectRoot 'projects/workspace-standard/PROJECT-STATE.yaml'

# Function to load YAML file
function Load-Yaml {
    param([string]$Path)
    if (-not (Test-Path $Path)) {
        Write-Error ("File not found: {0}" -f $Path)
        return $null
    }
    try {
        return Get-Content $Path -Raw | ConvertFrom-Yaml
    } catch {
        Write-Error ("Failed to parse YAML file {0}: {1}" -f $Path, $_)
        return $null
    }
}

# Function to save YAML file
function Save-Yaml {
    param([object]$Data, [string]$Path)
    try {
        $Data | ConvertTo-Yaml -Depth 10 | Set-Content -Path $Path -Encoding UTF8
        return $true
    } catch {
        Write-Error ("Failed to save YAML file {0}: {1}" -f $Path, $_)
        return $false
    }
}

# 1. Load and validate task contract
Write-Host "Loading task contract from $TaskContractPath"
$taskContract = Load-Yaml -Path $TaskContractPath
if (-not $taskContract) {
    exit 1
}

# Validate required fields
$requiredFields = @('task_id', 'task_type', 'objective', 'scope', 'assigned_agent')
foreach ($field in $requiredFields) {
    if (-not $taskContract.$field) {
        Write-Error "Missing required field in task contract: $field"
        exit 1
    }
}

# 2. Load Project Truth and State
Write-Host "Loading Project Truth and State"
$projectTruth = Get-Content -Path $ProjectTruthPath -Raw
$projectState = Load-Yaml -Path $ProjectStatePath
if (-not $projectState) {
    # Initialize a basic state if file doesn't exist or is invalid
    $projectState = @{
        metadata = @{
            version = "1.0.0"
            last_updated = (Get-Date -Format o)
            status = "INITIALIZING"
        }
        lifecycle = @{
            current_state = "CONSTRUCTION"
            phase = "PHASE_2_3"
        }
        active_tasks = @()
        locks = @{}
        evidence_registry = @{}
        unknowns = @()
    }
    Save-Yaml -Data $projectState -Path $ProjectStatePath
}

# 3. Governance Admission via Control Plane
Write-Host "Submitting task to governance enforcement"
$governanceResult = & "$ScriptRoot\..\control-plane\governance-enforcement.ps1" -TaskContractPath $TaskContractPath -ProjectTruthPath $ProjectTruthPath -ProjectStatePath $ProjectStatePath
if (-not $governanceResult) {
    Write-Error "Governance enforcement failed to return a result"
    exit 1
}

# Convert governance result from JSON if it's a string
if ($governanceResult -is [string]) {
    try {
        $governanceResult = $governanceResult | ConvertFrom-Json
    } catch {
        Write-Error "Governance enforcement returned invalid JSON: $_"
        exit 1
    }
}

if (-not $governanceResult.allowed) {
    Write-Error "Governance enforcement denied task: $($governanceResult.reason)"
    exit 1
}

# 4. Acquire lock on project state
Write-Host "Acquiring lock on project state"
$lockKey = "orchestrator_execution_$($taskContract.task_id)"
$projectState.locks[$lockKey] = @{
    acquired_by = "orchestrator"
    acquired_at = (Get-Date -Format o)
    task_id = $taskContract.task_id
}
if (-not (Save-Yaml -Data $projectState -Path $ProjectStatePath)) {
    Write-Error "Failed to acquire lock on project state"
    exit 1
}

try {
    # 5. Execute task using engine registry
    Write-Host "Looking up engine for task type: $($taskContract.task_type)"
    $registry = Load-Yaml -Path (Join-Path $ScriptRoot 'registry.yaml')
    if (-not $registry) {
        throw "Failed to load engine registry"
    }

    $engineInfo = $registry.engines.$($taskContract.task_type)
    if (-not $engineInfo) {
        # Try to find by task pattern in decisions
        $decision = $registry.decisions | Where-Object { $_.task_pattern -eq $taskContract.task_type } | Select-Object -First 1
        if ($decision) {
            $engineInfo = $registry.engines.$($decision.engine)
        }
    }

    if (-not $engineInfo) {
        throw "No engine found for task type '$($taskContract.task_type)'"
    }

    $engineScript = Join-Path $ScriptRoot 'engines' "$($engineInfo.type).ps1"
    if (-not (Test-Path $engineScript)) {
        # Fallback to .ps1 extension based on engine name
        $engineScript = Join-Path $ScriptRoot 'engines' "$($taskContract.task_type).ps1"
        if (-not (Test-Path $engineScript)) {
            throw "Engine script not found: $engineScript"
        }
    }

    Write-Host "Executing task with engine: $engineScript"
    $executionResult = & $engineScript -TaskContractPath $TaskContractPath
    if (-not $executionResult) {
        throw "Engine execution failed"
    }

    # 6. Persist execution results to project state
    Write-Host "Updating project state with execution results"
    $executionRecord = @{
        task_id = $taskContract.task_id
        timestamp = (Get-Date -Format o)
        engine_used = $engineInfo.type
        execution_result = $executionResult
    }
    if (-not $projectState.execution_records) {
        $projectState.execution_records = @()
    }
    $projectState.execution_records += $executionRecord

    # 7. Invoke validation engine
    Write-Host "Invoking validation engine"
    $validationResult = & "$ScriptRoot\..\control-plane\validation-engine.ps1" -TaskID $taskContract.task_id -ExecutionResult $executionResult
    if (-not $validationResult) {
        throw "Validation engine failed to return a result"
    }

    if ($validationResult -is [string]) {
        try {
            $validationResult = $validationResult | ConvertFrom-Json
        } catch {
            Write-Error "Validation engine returned invalid JSON: $_"
            throw "Validation engine returned invalid JSON"
        }
    }

    if (-not $validationResult.passed) {
        throw "Validation failed: $($validationResult.reason)"
    }

    # 8. Update task status to completed
    Write-Host "Marking task as completed"
    $taskEntry = $projectState.active_tasks | Where-Object { $_.task_id -eq $taskContract.task_id } | Select-Object -First 1
    if ($taskEntry) {
        $taskEntry.status = "COMPLETED"
        $taskEntry.completed_at = (Get-Date -Format o)
    } else {
        # Add new entry if not found
        $projectState.active_tasks += @{
            task_id = $taskContract.task_id
            objective = $taskContract.objective
            status = "COMPLETED"
            assigned_agent = $taskContract.assigned_agent
            completed_at = (Get-Date -Format o)
        }
    }

    # 9. Generate evidence
    Write-Host "Generating evidence"
    $evidence = @{
        task_id = $taskContract.task_id
        timestamp = (Get-Date -Format o)
        objective = $taskContract.objective
        engine_used = $engineInfo.type
        execution_result = $executionResult
        validation_result = $validationResult
        project_state_snapshot = $projectState
    }
    $evidencePath = Join-Path $ProjectRoot 'evidence' "$($taskContract.task_id)_evidence.json"
    if (-not (Test-Path (Join-Path $ProjectRoot 'evidence'))) {
        New-Item -ItemType Directory -Path (Join-Path $ProjectRoot 'evidence') | Out-Null
    }
    $evidence | ConvertTo-Yaml -Depth 5 | Set-Content -Path $evidencePath -Encoding UTF8

    # Update evidence registry
    if (-not $projectState.evidence_registry) {
        $projectState.evidence_registry = @{}
    }
    $projectState.evidence_registry.last_evidence_id = $taskContract.task_id
    $projectState.evidence_registry."$($taskContract.task_id)_path" = $evidencePath

    Write-Host "Task $($taskContract.task_id) completed successfully"
    exit 0
} finally {
    # 10. Release lock
    Write-Host "Releasing lock on project state"
    if ($projectState.locks.ContainsKey($lockKey)) {
        $projectState.locks.Remove($lockKey)
        Save-Yaml -Data $projectState -Path $ProjectStatePath
    }
}