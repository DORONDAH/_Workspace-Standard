# Test Decision → Approval → Execution → Validation flow

# Import the Control Plane modules if needed
# Assuming the scripts are in the control-plane directory relative to the repo root
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$controlPlaneDir = Join-Path $scriptDir '..\control-plane'

# Helper function to run a command and capture output and exit code
function Invoke-TestCommand {
    param(
        [string]$Command,
        [string]$Description
    )
    Write-Host "Running: $Description"
    try {
        $result = & $Command 2>&1
        $exitCode = $LASTEXITCODE
        return @{ Output = $result; ExitCode = $exitCode }
    } catch {
        return @{ Output = $_; ExitCode = 1 }
    }
}

# Test 1: Attempt to execute a task without authorization (should fail)
Write-Host "=== Test 1: Unauthorized execution attempt ==="
$unauthResult = Invoke-TestCommand -Command "powershell -NoProfile -ExecutionPolicy Bypass -File `"$controlPlaneDir\governance-enforcement.ps1`" -Action execute -TaskId test-unauth-task" -Description "Testing governance enforcement for unauthorized execution"
if ($unauthResult.ExitCode -ne 0) {
    Write-Host "PASS: Unauthorized execution correctly blocked." -ForegroundColor Green
    $test1Pass = $true
} else {
    Write-Host "FAIL: Unauthorized execution was not blocked." -ForegroundColor Red
    $test1Pass = $false
}
Write-Host "Output: $($unauthResult.Output)"
Write-Host ""

# Test 2: Request authorization through the Control Plane
Write-Host "=== Test 2: Request authorization ==="
# We'll simulate a decision and approval by creating a task contract and then approving it
# For simplicity, we'll assume the Control Plane has a way to approve tasks.
# In a real scenario, this would involve the Supervisor role.
# We'll create a simple task contract file and then use the State-Machine to approve it.
$taskContract = @"
id: test-auth-task
objective: "Test task for authorization flow"
assigned_agent: "TestAgent"
required_authority: "Supervisor"
"@
$taskContractPath = Join-Path $scriptDir 'test-auth-task.yaml'
Set-Content -Path $taskContractPath -Value $taskContract

# Now, we'll try to approve the task (this would normally be done by a Supervisor)
# For the purpose of this test, we'll simulate approval by updating the task state.
# We'll use the State-Machine script to transition the task to approved state.
$approveResult = Invoke-TestCommand -Command "powershell -NoProfile -ExecutionPolicy Bypass -File `"$controlPlaneDir\State-Machine.ps1`" -Action approve -TaskId test-auth-task -TaskContractPath `"$taskContractPath`"" -Description "Approving test task"
if ($approveResult.ExitCode -eq 0) {
    Write-Host "PASS: Task approval succeeded." -ForegroundColor Green
    $test2Pass = $true
} else {
    Write-Host "FAIL: Task approval failed." -ForegroundColor Red
    $test2Pass = $false
}
Write-Host "Output: $($approveResult.Output)"
Write-Host ""

# Test 3: Execute the task after authorization
Write-Host "=== Test 3: Authorized execution ==="
$execResult = Invoke-TestCommand -Command "powershell -NoProfile -ExecutionPolicy Bypass -File `"$controlPlaneDir\governance-enforcement.ps1`" -Action execute -TaskId test-auth-task" -Description "Executing authorized task"
if ($execResult.ExitCode -eq 0) {
    Write-Host "PASS: Authorized execution succeeded." -ForegroundColor Green
    $test3Pass = $true
} else {
    Write-Host "FAIL: Authorized execution failed." -ForegroundColor Red
    $test3Pass = $false
}
Write-Host "Output: $($execResult.Output)"
Write-Host ""

# Test 4: Validate the results
Write-Host "=== Test 4: Validation ==="
$validateResult = Invoke-TestCommand -Command "powershell -NoProfile -ExecutionPolicy Bypass -File `"$controlPlaneDir\validation-engine.ps1`" -TaskId test-auth-task" -Description "Validating task execution"
if ($validateResult.ExitCode -eq 0) {
    Write-Host "PASS: Validation succeeded." -ForegroundColor Green
    $test4Pass = $true
} else {
    Write-Host "FAIL: Validation failed." -ForegroundColor Red
    $test4Pass = $false
}
Write-Host "Output: $($validateResult.Output)"
Write-Host ""

# Test 5: Verify evidence was recorded
Write-Host "=== Test 5: Evidence recording ==="
# Check if evidence was recorded in the PROJECT-STATE.yaml or evidence registry
$evidenceCheck = Invoke-TestCommand -Command "powershell -NoProfile -ExecutionPolicy Bypass -File `"$controlPlaneDir\State-Machine.ps1`" -Action get-evidence -TaskId test-auth-task" -Description "Checking evidence for task"
if ($evidenceCheck.ExitCode -eq 0 -and $evidenceCheck.Output -match "evidence") {
    Write-Host "PASS: Evidence was recorded." -ForegroundColor Green
    $test5Pass = $true
} else {
    Write-Host "FAIL: Evidence was not recorded or check failed." -ForegroundColor Red
    $test5Pass = $false
}
Write-Host "Output: $($evidenceCheck.Output)"
Write-Host ""

# Summary
Write-Host "=== Test Summary ==="
$allPass = $test1Pass -and $test2Pass -and $test3Pass -and $test4Pass -and $test5Pass
if ($allPass) {
    Write-Host "All tests passed!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "Some tests failed." -ForegroundColor Red
    exit 1
}