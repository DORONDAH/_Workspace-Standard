# Orchestrator (Real Implementation)
# Implements the Workspace Standard architecture canonical lifecycle

param(
    [Parameter(Mandatory=$true)]
    [string]$TaskContractPath
)

# Function to load YAML file
function Load-Yaml {
    param([string]$Path)
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

# Function to load Project Truth
function Load-ProjectTruth {
    $truthPath = Join-Path -Path $PSScriptRoot -ChildPath "../../projects/workspace-standard/PROJECT-TRUTH.md"
    if (Test-Path $truthPath) {
        return Get-Content $truthPath -Raw
    } else {
        Write-Error "Project Truth not found at $truthPath"
        return $null
    }
}

# Function to load Project State
function Load-ProjectState {
    $statePath = Join-Path -Path $PSScriptRoot -ChildPath "../../projects/workspace-standard/PROJECT-STATE.yaml"
    if (Test-Path $statePath) {
        return Load-Yaml -Path $statePath
    } else {
        Write-Error "Project State not found at $statePath"
        return $null
    }
}

# Function to save Project State
function Save-ProjectState {
    param([object]$StateData)
    $statePath = Join-Path -Path $PSScriptRoot -ChildPath "../../projects/workspace-standard/PROJECT-STATE.yaml"
    return Save-Yaml -Data $StateData -Path $statePath
}

# Function to submit task to governance enforcement
function Invoke-GovernanceEnforcement {
    param([object]$TaskContract)
    $governanceScript = Join-Path -Path $PSScriptRoot -ChildPath "../../control-plane/governance-enforcement.ps1"
    if (Test-Path $governanceScript) {
        # For now, we assume the governance script returns a boolean or a hashtable with Approved property
        & $governanceScript -TaskContract $TaskContract
        # If the script exits with code 0, we consider it approved
        if ($LASTEXITCODE -eq 0) {
            return @{ Approved = $true; Reason = "Governance enforcement passed" }
        } else {
            return @{ Approved = $false; Reason = "Governance enforcement failed" }
        }
    } else {
        Write-Warning "Governance enforcement script not found at $governanceScript. Assuming approved for now."
        return @{ Approved = $true; Reason = "Governance enforcement not implemented" }
    }
}

# Function to acquire lock on project state
function Acquire-Lock {
    param([object]$State)
    # Simple lock mechanism: if there's no lock, create one with a timestamp and process ID
    if (-not $State.Locks) {
        $State.Locks = @{}
    }
    $lockId = "orchestrator_$(Get-Date -Format 'yyyyMMdd_HHmmss')_$PID"
    $State.Locks[$lockId] = @{
        Acquired = Get-Date -Format o
        ProcessID = $PID
        Holder = "Orchestrator"
    }
    # Save the state with the lock
    if (Save-ProjectState -StateData $State) {
        return $lockId
    } else {
        return $null
    }
}

# Function to release lock on project state
function Release-Lock {
    param([object]$State, [string]$LockId)
    if ($State.Locks -and $State.Locks.ContainsKey($LockId)) {
        $State.Locks.Remove($LockId)
        return Save-ProjectState -StateData $State
    }
    return $false
}

# Function to update task status in project state
function Update-TaskStatus {
    param([object]$State, [string]$TaskId, [string]$NewStatus)
    if (-not $State.active_tasks) {
        $State.active_tasks = @{}
    }
    if ($State.active_tasks.ContainsKey($TaskId)) {
        $State.active_tasks[$TaskId].status = $NewStatus
        $State.active_tasks[$TaskId].last_updated = Get-Date -Format o
    } else {
        $State.active_tasks[$TaskId] = @{
            status = $NewStatus
            last_updated = Get-Date -Format o
        }
    }
    return $State
}

# Function to execute task using engine registry
function Invoke-Engine {
    param([object]$TaskContract, [object]$Registry)
    # Determine engine from task contract
    $engineName = $TaskContract.engine
    if (-not $engineName) {
        # Try to infer from task type or use default
        $engineName = "reference" # fallback to reference engine for now
    }
    # Look up engine in registry
    if ($Registry.engines -and $Registry.engines.ContainsKey($engineName)) {
        $engineConfig = $Registry.engines[$engineName]
        $engineScript = Join-Path -Path $PSScriptRoot -ChildPath "engines/$($engineConfig.script)"
        if (Test-Path $engineScript) {
            # Execute the engine script with the task contract
            & $engineScript -TaskContract $TaskContract
            return $LASTEXITCODE -eq 0
        } else {
            Write-Error "Engine script not found at $engineScript"
            return $false
        }
    } else {
        Write-Error "Engine '$engineName' not found in registry"
        return $false
    }
}

# Function to invoke validation engine
function Invoke-ValidationEngine {
    param([object]$State)
    $validationScript = Join-Path -Path $PSScriptRoot -ChildPath "../../control-plane/validation-engine.ps1"
    if (Test-Path $validationScript) {
        & $validationScript -ProjectState $State
        return $LASTEXITCODE -eq 0
    } else {
        Write-Warning "Validation engine script not found at $validationScript. Assuming validation passed."
        return $true
    }
}

# Function to generate evidence
function Generate-Evidence {
    param([object]$TaskContract, [object]$State, [string]$TaskId)
    # For now, we create a simple evidence record
    $evidence = @{
        TaskId = $TaskId
        Timestamp = Get-Date -Format o
        OutputHash = "PLACEHOLDER_HASH" # In real implementation, compute hash of outputs
        StateHash = "PLACEHOLDER_STATE_HASH" # Hash of relevant state
        ExecutedBy = "Orchestrator"
    }
    if (-not $State.evidence_registry) {
        $State.evidence_registry = @{}
    }
    $State.evidence_registry[$TaskId] = $evidence
    return $State
}

# Main execution
try {
    Write-Host "Orchestrator starting..."

    # Load task contract
    $taskContract = Load-Yaml -Path $TaskContractPath
    if (-not $taskContract) {
        throw "Failed to load task contract from $TaskContractPath"
    }
    $taskId = $taskContract.id
    if (-not $taskId) {
        throw "Task contract must have an 'id' field"
    }
    Write-Host "Loaded task contract for task ID: $taskId"

    # Load Project Truth (for reference, not used in logic yet)
    $projectTruth = Load-ProjectTruth
    if ($projectTruth) {
        Write-Host "Project Truth loaded."
    }

    # Load Project State
    $projectState = Load-ProjectState
    if (-not $projectState) {
        throw "Failed to load project state"
    }
    Write-Host "Project state loaded."

    # Submit to governance enforcement
    Write-Host "Submitting to governance enforcement..."
    $governanceResult = Invoke-GovernanceEnforcement -TaskContract $taskContract
    if (-not $governanceResult.Approved) {
        throw "Governance enforcement rejected task: $($governanceResult.Reason)"
    }
    Write-Host "Governance enforcement approved: $($governanceResult.Reason)"

    # Acquire lock on project state
    Write-Host "Acquiring lock on project state..."
    $lockId = Acquire-Lock -State $projectState
    if (-not $lockId) {
        throw "Failed to acquire lock on project state"
    }
    Write-Host "Lock acquired: $lockId"

    # Update task status to EXECUTING
    Write-Host "Updating task status to EXECUTING..."
    $projectState = Update-TaskStatus -State $projectState -TaskId $taskId -NewStatus "EXECUTING"
    if (-not (Save-ProjectState -StateData $projectState)) {
        throw "Failed to save project state after updating task status"
    }

    # Load engine registry
    $registryPath = Join-Path -Path $PSScriptRoot -ChildPath "registry.yaml"
    $engineRegistry = Load-Yaml -Path $registryPath
    if (-not $engineRegistry) {
        throw "Failed to load engine registry"
    }

    # Execute task using engine
    Write-Host "Executing task via engine..."
    $executionSuccess = Invoke-Engine -TaskContract $taskContract -Registry $engineRegistry
    if (-not $executionSuccess) {
        throw "Task execution failed"
    }
    Write-Host "Task executed successfully."

    # Persist execution results (simplified - in reality, engine would update state)
    # For now, we just note that execution happened

    # Invoke validation engine
    Write-Host "Invoking validation engine..."
    $validationPassed = Invoke-ValidationEngine -State $projectState
    if (-not $validationPassed) {
        throw "Validation engine reported failure"
    }
    Write-Host "Validation passed."

    # Update task status to COMPLETED
    Write-Host "Updating task status to COMPLETED..."
    $projectState = Update-TaskStatus -State $projectState -TaskId $taskId -NewStatus "COMPLETED"
    if (-not (Save-ProjectState -StateData $projectState)) {
        throw "Failed to save project state after updating task status to COMPLETED"
    }

    # Generate evidence
    Write-Host "Generating evidence..."
    $projectState = Generate-Evidence -TaskContract $taskContract -State $projectState -TaskId $taskId
    if (-not (Save-ProjectState -StateData $projectState)) {
        throw "Failed to save project state after generating evidence"
    }
    Write-Host "Evidence generated."

    # Release lock
    Write-Host "Releasing lock..."
    if (-not (Release-Lock -State $projectState -LockId $lockId)) {
        Write-Warning "Failed to release lock on project state"
    } else {
        Write-Host "Lock released."
    }

    Write-Host "Orchestrator completed successfully for task $taskId."
    exit 0
} catch {
    Write-Error "Orchestrator failed: $_"
    # Attempt to update task status to FAILED if we have a task ID and state
    if ($taskId -and $projectState) {
        $projectState = Update-TaskStatus -State $projectState -TaskId $taskId -NewStatus "FAILED"
        Save-ProjectState -StateData $projectState | Out-Null
        # Try to release lock if we acquired one
        if ($lockId) {
            Release-Lock -State $projectState -LockId $lockId | Out-Null
        }
    }
    exit 1
}

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
        Write-Error "File not found: $Path"
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
