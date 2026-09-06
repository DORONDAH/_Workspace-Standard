# State-Machine.ps1

# Manages the canonical lifecycle states for governed tasks.

param (
    [string]$TaskID,
    [string]$NewState
)

# Canonical States
$States = @("CREATED", "CLASSIFIED", "PLANNED", "RESEARCHED", "CRITICIZED", "APPROVED", "EXECUTING", "EXECUTED", "VALIDATING", "VALIDATED", "COMPLETED", "FAILED", "REJECTED", "BLOCKED", "ROLLBACK_REQUIRED", "ROLLED_BACK", "ESCALATED")

function Update-TaskState {
    param([string]$TaskID, [string]$NewState)

    if ($States -notcontains $NewState) {
        Write-Error "Invalid state: $NewState"
        exit 1
    }

    # Logic to write to PROJECT-STATE.yaml
    Write-Host "Updating Task $TaskID to $NewState"
}

Update-TaskState -TaskID $TaskID -NewState $NewState
