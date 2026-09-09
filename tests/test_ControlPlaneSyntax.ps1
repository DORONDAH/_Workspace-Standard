# Test Control Plane script syntax

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$controlPlaneDir = Join-Path $scriptDir '..\control-plane'
$scripts = @(
    "governance-enforcement.ps1",
    "State-Machine.ps1",
    "validation-engine.ps1",
    "control-plane.ps1"
)

$allPassed = $true

foreach ($script in $scripts) {
    $path = Join-Path $controlPlaneDir $script
    Write-Host "Checking syntax of $script..."
    try {
        # Use PowerShell to parse the script without executing
        $result = & powershell -NoProfile -ExecutionPolicy Bypass -Command "& { try { [System.Management.Automation.Language.Parser]::ParseFile('$path', [ref]$tokens, [ref]$errors) | Out-Null; if ($errors.Count -eq 0) { Write-Output 'SYNTAX_OK' } else { Write-Output 'SYNTAX_ERROR: $errors' } } catch { Write-Output 'EXCEPTION: $_' } }"
        if ($result -eq 'SYNTAX_OK') {
            Write-Host "PASS: $script syntax is OK." -ForegroundColor Green
        } else {
            Write-Host "FAIL: $script syntax check failed: $result" -ForegroundColor Red
            $allPassed = $false
        }
    } catch {
        Write-Host "FAIL: Exception while checking $script: $_" -ForegroundColor Red
        $allPassed = $false
    }
    Write-Host ""
}

if ($allPassed) {
    Write-Host "All syntax checks passed." -ForegroundColor Green
    exit 0
} else {
    Write-Host "Some syntax checks failed." -ForegroundColor Red
    exit 1
}