# Validation Engine (Real Implementation)

param (
    [string]$TaskID,
    [hashtable]$ExecutionResult
)

# Define paths
$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ProjectRoot = Split-Path -Parent $ScriptRoot
$ProjectStatePath = Join-Path $ProjectRoot 'projects/workspace-standard/PROJECT-STATE.yaml'
$EvidencePath = Join-Path $ProjectRoot 'evidence' "$($TaskID)_evidence.json"

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
        Write-Error "Failed to parse YAML file $Path: $_"
        return $null
    }
}

# Function to load JSON file
function Load-Json {
    param([string]$Path)
    if (-not (Test-Path $Path)) {
        Write-Error "File not found: $Path"
        return $null
    }
    try {
        return Get-Content $Path -Raw | ConvertFrom-Json
    } catch {
        Write-Error "Failed to parse JSON file $Path: $_"
        return $null
    }
}

# Load project state
Write-Host "Loading project state from $ProjectStatePath"
$projectState = Load-Yaml -Path $ProjectStatePath
if (-not $projectState) {
    Write-Error "Failed to load project state"
    exit 1
}

# Load evidence if available
$evidence = $null
if (Test-Path $EvidencePath) {
    $evidence = Load-Json -Path $EvidencePath
}

# Perform independent validation
$validationResult = @{
    passed = $false
    reason = ""
    checks = @()
}

# Check 1: Task exists in project state
$taskEntry = $projectState.active_tasks | Where-Object { $_.task_id -eq $TaskID } | Select-Object -First 1
if (-not $taskEntry) {
    $validationResult.reason = "Task ID '$TaskID' not found in project state"
    $validationResult.checks += @{
        check = "task_exists"
        passed = $false
        detail = "Task not found in active_tasks"
    }
} else {
    $validationResult.checks += @{
        check = "task_exists"
        passed = $true
        detail = "Task found in active_tasks with state: $($taskEntry.state)"
    }
}

# Check 2: Evidence exists and is valid
if ($evidence) {
    $validationResult.checks += @{
        check = "evidence_exists"
        passed = $true
        detail = "Evidence file found at $EvidencePath"
    }

    # Check evidence consistency
    if ($evidence.task_id -eq $TaskID) {
        $validationResult.checks += @{
            check = "evidence_task_id_match"
            passed = $true
            detail = "Evidence task_id matches"
        }
    } else {
        $validationResult.checks += @{
            check = "evidence_task_id_match"
            passed = $false
            detail = "Evidence task_id mismatch: expected '$TaskID', got '$($evidence.task_id)'"
        }
    }
} else {
    $validationResult.checks += @{
        check = "evidence_exists"
        passed = $false
        detail = "Evidence file not found at $EvidencePath"
    }
}

# Check 3: Execution result consistency (if provided)
if ($ExecutionResult) {
    $validationResult.checks += @{
        check = "execution_result_provided"
        passed = $true
        detail = "Execution result provided to validation engine"
    }

    # Compare with evidence if available
    if ($evidence -and $evidence.execution_result) {
        # Simple comparison - in reality this would be more sophisticated
        if ($evidence.execution_result -eq $ExecutionResult) {
            $validationResult.checks += @{
                check = "execution_result_consistent"
                passed = $true
                detail = "Execution result matches evidence"
            }
        } else {
            $validationResult.checks += @{
                check = "execution_result_consistent"
                passed = $false
                detail = "Execution result does not match evidence"
            }
        }
    }
} else {
    $validationResult.checks += @{
        check = "execution_result_provided"
        passed = $false
        detail = "No execution result provided to validation engine"
    }
}

# Check 4: Task state is appropriate for validation
if ($taskEntry) {
    $validStatesForValidation = @("EXECUTED", "VALIDATING", "COMPLETED")
    if ($validStatesForValidation -contains $taskEntry.state) {
        $validationResult.checks += @{
            check = "task_state_valid"
            passed = $true
            detail = "Task state '$($taskEntry.state)' is valid for validation"
        }
    } else {
        $validationResult.checks += @{
            check = "task_state_valid"
            passed = $false
            detail = "Task state '$($taskEntry.state)' is not valid for validation (expected one of: $($validStatesForValidation -join ', '))"
        }
    }
}

# Determine overall validation result
$failedChecks = $validationResult.checks | Where-Object { -not $_.passed }
if ($failedChecks.Count -eq 0) {
    $validationResult.passed = $true
    $validationResult.reason = "All validation checks passed"
} else {
    $validationResult.passed = $false
    $failedDetails = $failedChecks | ForEach-Object { $_.detail }
    $validationResult.reason = "Validation failed: $($failedDetails -join '; ')"
}

# Output result as JSON
$validationResult | ConvertTo-Json -Depth 5
exit 0
