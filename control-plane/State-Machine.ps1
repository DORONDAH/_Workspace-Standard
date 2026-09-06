# State Machine (Real Implementation)

param (
    [string]$TaskID,
    [string]$NewState
)

# Define paths
$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ProjectRoot = Split-Path -Parent $ScriptRoot
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
        Write-Error "Failed to parse YAML file $Path: $_"
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
        Write-Error "Failed to save YAML file $Path: $_"
        return $false
    }
}

# Canonical States (in order)
$States = @(
    "CREATED", "CLASSIFIED", "PLANNED", "RESEARCHED", "CRITICIZED", "APPROVED",
    "EXECUTING", "EXECUTED", "VALIDATING", "VALIDATED", "COMPLETED",
    "FAILED", "REJECTED", "BLOCKED", "ROLLBACK_REQUIRED", "ROLLED_BACK", "ESCALATED"
)

# Terminal states (can be transitioned to from any state)
$TerminalStates = @("FAILED", "REJECTED", "BLOCKED", "ROLLBACK_REQUIRED", "ROLLED_BACK", "ESCALATED")

# Load project state
Write-Host "Loading project state from $ProjectStatePath"
$projectState = Load-Yaml -Path $ProjectStatePath
if (-not $projectState) {
    Write-Error "Failed to load project state"
    exit 1
}

# Find the task in active_tasks
$taskIndex = -1
for ($i = 0; $i -lt $projectState.active_tasks.Count; $i++) {
    if ($projectState.active_tasks[$i].task_id -eq $TaskID) {
        $taskIndex = $i
        break
    }
}

if ($taskIndex -eq -1) {
    Write-Error "Task with ID '$TaskID' not found in active tasks"
    exit 1
}

$currentState = $projectState.active_tasks[$taskIndex].state
Write-Host "Current state of task $TaskID: $currentState"
Write-Host "Requested new state: $NewState"

# Validate NewState is a known state
if ($States -notcontains $NewState) {
    Write-Error "Invalid state: $NewState. Must be one of: $($States -join ', ')"
    exit 1
}

# Validate transition
$transitionAllowed = $false

# Same state transition is not allowed (unless we want to allow idempotency? We'll disallow for now)
if ($currentState -eq $NewState) {
    Write-Error "Transition from $currentState to $NewState is not allowed (same state)"
    exit 1
}

# Terminal states can be transitioned to from any state
if ($TerminalStates -contains $NewState) {
    $transitionAllowed = $true
} else {
    # For non-terminal states, only allow forward progression in the canonical order
    $currentIndex = [Array]::IndexOf($States, $currentState)
    $newIndex = [Array]::IndexOf($States, $NewState)

    if ($currentIndex -ge 0 -and $newIndex -gt $currentIndex) {
        $transitionAllowed = $true
    }
}

if (-not $transitionAllowed) {
    Write-Error "Invalid transition from '$currentState' to '$NewState'. Allowed transitions are: forward in canonical order or to any terminal state."
    exit 1
}

# Update the task state
$projectState.active_tasks[$taskIndex].state = $NewState
$projectState.active_tasks[$taskIndex].updated_at = (Get-Date -Format o)

# Update project state metadata
$projectState.metadata.last_updated = (Get-Date -Format o)

# Save the updated project state
if (-not (Save-Yaml -Data $projectState -Path $ProjectStatePath)) {
    Write-Error "Failed to save updated project state"
    exit 1
}

Write-Host "Task $TaskID transitioned from $currentState to $NewState successfully"
exit 0
