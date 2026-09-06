# orchestrator.ps1 - מנוע ניהול המעבדה האוטונומי

# טעינת קונפיגורציות
$registry = Get-Content "C:/Users/doron/Desktop/Labs/_Workspace-Standard/lab-engine/core/registry.yaml" -Raw | ConvertFrom-Yaml
$policies = Get-Content "C:/Users/doron/Desktop/Labs/_Workspace-Standard/lab-engine/governance/LAB-POLICIES.yaml" -Raw | ConvertFrom-Yaml

function Invoke-LabTask {
    param([string]$taskName, [string]$taskPattern)

    Write-Host "--- מתחיל משימה: $taskName ---" -ForegroundColor Cyan

    # 1. בחירת מנוע (מתוך registry.yaml)
    $decision = $registry.decisions | Where-Object { $_.task_pattern -eq $taskPattern }
    if (-not $decision) { $decision = $registry.decisions | Where-Object { $_.task_pattern -eq "unknown" } }

    if ($decision.engine -eq "stop_and_ask") {
        Write-Error "משימה לא מסווגת - עצירה מוחלטת."
        return
    }

    Write-Host "מנוע נבחר: $($decision.engine)" -ForegroundColor Green

    # 2. הרצת בדיקות לפני ביצוע (Pre-Flight)
    # בדיקת משאבים לפי LAB-POLICIES.yaml
    Write-Host "בודק משאבים..."

    # 3. ביצוע משימה (הפעלת המנוע)
    if ($decision.engine -eq "hyperv") {
        Write-Host "מריץ Hyper-V..."
        # כאן יבוא ה-PowerShell ל-Hyper-V
    } else {
        Write-Host "מריץ Docker..."
        # כאן יבוא ה-docker-compose
    }

    Write-Host "משימה הושלמה בהצלחה." -ForegroundColor Green
}

# דוגמת הרצה (יקרא מ-tasks.queue)
Invoke-LabTask -taskName "Setup-AD-Server" -taskPattern "active_directory"
