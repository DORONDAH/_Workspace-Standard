# Simple test for Phase 7: Testing Authorization and Decision Gates

Write-Host "=== Phase 7 Simple Test ==="

# Check that the control plane scripts exist
$controlPlaneDir = "..\control-plane"
$scripts = @("governance-enforcement.ps1", "State-Machine.ps1", "validation-engine.ps1", "control-plane.ps1")
$allExist = $true
foreach ($script in $scripts) {
    $path = Join-Path $controlPlaneDir $script
    if (Test-Path $path) {
        Write-Host "PASS: $script exists." -ForegroundColor Green
    } else {
        Write-Host "FAIL: $script does not exist." -ForegroundColor Red
        $allExist = $false
    }
}

# Check that the agent contracts exist
$agentsDir = "..\agents"
$contracts = @("supervisor-contract.yaml", "executor-contract.yaml", "researcher-contract.yaml", "critic-contract.yaml", "validator-contract.yaml", "commander-contract.yaml")
$allContractsExist = $true
foreach ($contract in $contracts) {
    $path = Join-Path $agentsDir $contract
    if (Test-Path $path) {
        Write-Host "PASS: $contract exists." -ForegroundColor Green
    } else {
        Write-Host "FAIL: $contract does not exist." -ForegroundColor Red
        $allContractsExist = $false
    }
}

# Check that the lab engine orchestrator exists
$orchestratorPath = "..\lab-engine\core\orchestrator_new.ps1"
if (Test-Path $orchestratorPath) {
    Write-Host "PASS: Lab engine orchestrator exists." -ForegroundColor Green
} else {
    Write-Host "FAIL: Lab engine orchestrator does not exist." -ForegroundColor Red
}

# Overall result
if ($allExist -and $allContractsExist) {
    Write-Host "All Phase 7 prerequisite checks passed." -ForegroundColor Green
    exit 0
} else {
    Write-Host "Some Phase 7 prerequisite checks failed." -ForegroundColor Red
    exit 1
}