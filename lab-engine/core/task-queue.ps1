# task-queue.ps1

# Manages task queue processing and discovery.

param (
    [string]$Action # "discover", "claim", "complete"
)

$QueuePath = "C:/Users/doron/Desktop/Labs/_Workspace-Standard/lab-engine/tasks.queue"

function Get-PendingTasks {
    # Returns list of tasks in CREATED state
    Get-ChildItem -Path $QueuePath -Filter "*.yaml" | ForEach-Object {
        $task = Get-Content $_.FullName -Raw | ConvertFrom-Yaml
        if ($task.status -eq "CREATED") {
            return $task
        }
    }
}

switch ($Action) {
    "discover" { Get-PendingTasks }
    "claim"    { Write-Host "Claiming task..." }
    "complete" { Write-Host "Completing task..." }
}
