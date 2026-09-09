# Test that agents cannot execute without explicit authorization

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$controlPlaneDir = Join-Path $scriptDir '..\control-plane'

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

# Test 1: Agent attempts to execute without any authorization
Write-Host "=== Test 1: Agent execution without authorization ==="
$noAuthResult = Invoke-TestCommand -Command "powershell -NoProfile -ExecutionPolicy Bypass -File `"$controlPlaneDir\governance-enforcement.ps1`" -Action `execute` -TaskId `agent-no-auth-task` -AgentRole `Executor`" -Description "Testing agent execution without authorization"
if ($noAuthResult.ExitCode -ne 0) {
    Write-Host "PASS: Agent execution without authorization correctly blocked." -ForegroundColor Green
    $test1Pass = $true
} else {
    Write-Host "FAIL: Agent execution without authorization was not blocked." -ForegroundColor Red
    $test1Pass = $false
}
Write-Host "Output: $($noAuthResult.Output)"
Write-Host ""

# Test 2: Agent with Supervisor role attempts to execute (should still need explicit approval)
Write-Host "=== Test 2: Supervisor agent execution without explicit approval ==="
$supervisorResult = Invoke-TestCommand -Command "powershell -NoProfile -ExecutionPolicy Bypass -File `"$controlPlaneDir\governance-enforcement.ps1`" -Action `execute` -TaskId `agent-supervisor-task` -AgentRole `Supervisor`" -Description "Testing supervisor agent execution without explicit approval"
if ($supervisorResult.ExitCode -ne 0) {
    Write-Host "PASS: Supervisor agent execution without explicit approval correctly blocked." -ForegroundColor Green
    $test2Pass = $true
} else {
    Write-Host "FAIL: Supervisor agent execution without explicit approval was not blocked." -ForegroundColor Red
    $test2Pass = $false
}
Write-Host "Output: $($supervisorResult.Output)"
Write-Host ""

# Test 3: Agent with explicit authorization can execute
Write-Host "=== Test 3: Agent with explicit authorization ==="
# First, create and approve a task for the agent
$taskContract = @"
id: agent-auth-task
objective: "Test task for agent authorization"
assigned_agent: "TestAgent"
required_authority: "Supervisor"
"@
$taskContractPath = Join-Path $scriptDir 'agent-auth-task.yaml'
Set-Content -Path $taskContractPath -Value $taskContract

# Approve the task (simulating Supervisor approval)
$approveResult = Invoke-TestCommand -Command "powershell -NoProfile -ExecutionPolicy Bypass -File `"$controlPlaneDir\State-Machine.ps1`" -Action `approve` -TaskId `agent-auth-task` -TaskContractPath `"$taskContractPath`"" -Description "Approving agent task"
if ($approveResult.ExitCode -ne 0) {
    Write-Host "FAIL: Could not approve task for agent authorization test." -ForegroundColor Red
    $test3Pass = $false
    Write-Host "Output: $($approveResult.Output)"
    Write-Host ""
} else {
    # Now test that the agent can execute with authorization
    $authResult = Invoke-TestCommand -Command "powershell -NoProfile -ExecutionPolicy Bypass -File `"$controlPlaneDir\governance-enforcement.ps1`" -Action `execute` -TaskId `agent-auth-task` -AgentRole `Executor`" -Description "Testing agent execution with authorization"
    if ($authResult.ExitCode -eq 0) {
        Write-Host "PASS: Agent execution with authorization succeeded." -ForegroundColor Green
        $test3Pass = $true
    } else {
        Write-Host "FAIL: Agent execution with authorization failed." -ForegroundColor Red
        $test3Pass = $false
    }
    Write-Host "Output: $($authResult.Output)"
    Write-Host ""
}

# Summary
Write-Host "=== Test Summary ==="
$allPass = $test1Pass -and $test2Pass -and $test3Pass
if ($allPass) {
    Write-Host "All tests passed!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "Some tests failed." -ForegroundColor Red
    exit 1
}