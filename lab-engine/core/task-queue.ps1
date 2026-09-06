# Task Queue (Real Implementation)

param (
    [string]$Action, # "discover", "claim", "complete", "release"
    [string]$TaskID  # Required for claim, complete, release actions
)

# Define paths
$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ProjectRoot = Split-Path -Parent $ScriptRoot
$QueueDir = Join-Path $ProjectRoot 'lab-engine' 'queue'
$StatePath = Join-Path $ProjectRoot 'projects' 'workspace-standard' 'PROJECT-STATE.yaml'

# Ensure queue directory exists
if (-not (Test-Path $QueueDir)) {
    New-Item -ItemType Directory -Path $QueueDir | Out-Null
}

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

# Function to load project state
function Load-ProjectState {
    return Load-Yaml -Path $StatePath
}

# Function to save project state
function Save-ProjectState {
    param([object]$State)
    return Save-Yaml -Data $State -Path $StatePath
}

switch ($Action) {
    "discover" {
        # Discover tasks in CREATED state
        Write-Host "Discovering tasks in CREATED state..."
        $projectState = Load-ProjectState
        if (-not $projectState) {
            exit 1
        }

        $createdTasks = $projectState.active_tasks | Where-Object { $_.state -eq "CREATED" } | Select-Object -First 10
        if ($createdTasks) {
            # Output as JSON for easy consumption
            $createdTasks | ConvertTo-Json -Depth 3
        } else {
            # Return empty array
            @() | ConvertTo-Json
        }
        exit 0
    }

    "claim" {
        if (-not $TaskID) {
            Write-Error "TaskID is required for claim action"
            exit 1
        }

        Write-Host "Attempting to claim task $TaskID..."
        $projectState = Load-ProjectState
        if (-not $projectState) {
            exit 1
        }

        # Find the task
        $taskIndex = -1
        for ($i = 0; $i -lt $projectState.active_tasks.Count; $i++) {
            if ($projectState.active_tasks[$i].task_id -eq $TaskID) {
                $taskIndex = $i
                break
            }
        }

        if ($taskIndex -eq -1) {
            Write-Error "Task with ID '$TaskID' not found"
            exit 1
        }

        $task = $projectState.active_tasks[$taskIndex]

        # Check if task is in CREATED state
        if ($task.state -ne "CREATED") {
            Write-Error "Task is not in CREATED state (current state: $($task.state))"
            exit 1
        }

        # Check if task is already claimed (has a lease)
        if ($task.claimed_by -and $task.claim_expires) {
            $expiryTime = [datetime]$task.claim_expires
            if ($expiryTime -gt (Get-Date)) {
                Write-Error "Task is already claimed by $($task.claimed_by) until $($task.claim_expires)"
                exit 1
            } else {
                # Lease expired, clear it
                Write-Host "Clearing expired lease for task $TaskID"
                $task.claimed_by = $null
                $task.claim_expires = $null
            }
        }

        # Claim the task
        $claimDurationMinutes = 30 # Default claim duration
        $task.claimed_by = "orchestrator" # In a real system, this would be the caller ID
        $task.claimed_at = (Get-Date -Format o)
        $task.claim_expires = (Get-Date).AddMinutes($claimDurationMinutes).ToString("o")
        $task.state = "CLAIMED"

        # Save state
        if (-not (Save-ProjectState $projectState)) {
            Write-Error "Failed to save project state after claiming task"
            exit 1
        }

        Write-Host "Task $TaskID successfully claimed by orchestrator"
        # Output the claimed task details
        $task | ConvertTo-Json -Depth 3
        exit 0
    }

    "complete" {
        if (-not $TaskID) {
            Write-Error "TaskID is required for complete action"
            exit 1
        }

        Write-Host "Marking task $TaskID as completed..."
        $projectState = Load-ProjectState
        if (-not $projectState) {
            exit 1
        }

        # Find the task
        $taskIndex = -1
        for ($i = 0; $i -lt $projectState.active_tasks.Count; $i++) {
            if ($projectState.active_tasks[$i].task_id -eq $TaskID) {
                $taskIndex = $i
                break
            }
        }

        if ($taskIndex -eq -1) {
            Write-Error "Task with ID '$TaskID' not found"
            exit 1
        }

        $task = $projectState.active_tasks[$taskIndex]

        # Verify the task is claimed by orchestrator (or allow completion regardless in simplified version)
        # In a real system, we'd check the claim
        if ($task.state -notin @("CLAIMED", "EXECUTING", "EXECUTED", "VALIDATING")) {
            Write-Error "Task cannot be completed from state: $($task.state)"
            exit 1
        }

        # Mark as completed
        $task.state = "COMPLETED"
        $task.completed_at = (Get-Date -Format o)
        # Clear claim information
        $task.claimed_by = $null
        $task.claimed_at = $null
        $task.claim_expires = $null

        # Save state
        if (-not (Save-ProjectState $projectState)) {
            Write-Error "Failed to save project state after completing task"
            exit 1
        }

        Write-Host "Task $TaskID marked as completed"
        exit 0
    }

    "release" {
        if (-not $TaskID) {
            Write-Error "TaskID is required for release action"
            exit 1
        }

        Write-Host "Releasing claim on task $TaskID..."
        $projectState = Load-ProjectState
        if (-not $projectState) {
            exit 1
        }

        # Find the task
        $taskIndex = -1
        for ($i = 0; $i -lt $projectState.active_tasks.Count; $i++) {
            if ($projectState.active_tasks[$i].task_id -eq $TaskID) {
                $taskIndex = $i
                break
            }
        }

        if ($taskIndex -eq -1) {
            Write-Error "Task with ID '$TaskID' not found"
            exit 1
        }

        $task = $projectState.active_tasks[$taskIndex]

        # Clear claim information
        $task.claimed_by = $null
        $task.claimed_at = $null
        $task.claim_expires = $null
        # If we're releasing, typically go back to CREATED state
        if ($task.state -eq "CLAIMED") {
            $task.state = "CREATED"
        }

        # Save state
        if (-not (Save-ProjectState $projectState)) {
            Write-Error "Failed to save project state after releasing task claim"
            exit 1
        }

        Write-Host "Claim on task $TaskID released"
        exit 0
    }

    default {
        Write-Error "Invalid action: $Action. Valid actions are: discover, claim, complete, release"
        exit 1
    }
}
