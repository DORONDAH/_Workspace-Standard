# Governance Enforcement (Real Implementation)

param (
    [string]$TaskContractPath,
    [string]$ProjectTruthPath,
    [string]$ProjectStatePath
)

# Define paths
$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ProjectRoot = Split-Path -Parent $ScriptRoot

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

# Load inputs
Write-Host "Loading task contract from $TaskContractPath"
$taskContract = Load-Yaml -Path $TaskContractPath
if (-not $taskContract) {
    exit 1
}

Write-Host "Loading Project Truth from $ProjectTruthPath"
$projectTruth = Get-Content -Path $ProjectTruthPath -Raw
if (-not $projectTruth) {
    Write-Error "Failed to load Project Truth"
    exit 1
}

Write-Host "Loading Project State from $ProjectStatePath"
$projectState = Load-Yaml -Path $ProjectStatePath
if (-not $projectState) {
    Write-Error "Failed to load Project State"
    exit 1
}

# Governance evaluation function
function Invoke-GovernanceCheck {
    param(
        [hashtable]$Contract,
        [string]$Truth,
        [hashtable]$State
    )

    $result = @{
        allowed = $false
        reason = ""
        evaluations = @{}
    }

    # 1. Identity Verification
    $agentId = $Contract.assigned_agent
    $validAgents = @("commander", "orchestrator", "validator", "auditor")  # From Project Truth principles
    $identityValid = $validAgents -contains $agentId
    $result.evaluations.identity = @{
        valid = $identityValid
        agent = $agentId
        valid_agents = $validAgents
    }
    if (-not $identityValid) {
        $result.reason = "Invalid agent identity: $agentId"
        return $result
    }

    # 2. Authority Verification
    $authorityLevel = $Contract.authority_level ?? "standard"
    $maxAuthority = $State.metadata.max_authority_level ?? "standard"
    $authorityLevels = @("none", "read", "standard", "elevated", "admin")
    $agentIndex = [Array]::IndexOf($authorityLevels, $authorityLevel)
    $maxIndex = [Array]::IndexOf($authorityLevels, $maxAuthority)
    $authorityValid = $agentIndex -le $maxIndex
    $result.evaluations.authority = @{
        valid = $authorityValid
        agent_level = $authorityLevel
        max_allowed = $maxAuthority
    }
    if (-not $authorityValid) {
        $result.reason = "Insufficient authority: $authorityLevel (max allowed: $maxAuthority)"
        return $result
    }

    # 3. Scope Verification
    $requestedScope = $Contract.scope
    $allowedScopes = @()
    if ($State.policy.allowed_scopes) {
        $allowedScopes = $State.policy.allowed_scopes
    } else {
        # Default allowed scopes from Project Truth
        $allowedScopes = @("workspace", "local", "project")
    }
    $scopeValid = $allowedScopes -contains $requestedScope
    $result.evaluations.scope = @{
        valid = $scopeValid
        requested = $requestedScope
        allowed = $allowedScopes
    }
    if (-not $scopeValid) {
        $result.reason = "Scope violation: $requestedScope not in allowed scopes"
        return $result
    }

    # 4. Policy Verification
    $policyChecks = @()
    # Check against explicit prohibitions
    $prohibitedTools = @("rm", "del", "format", "fdisk")  # Dangerous tools
    if ($Contract.tools) {
        foreach ($tool in $Contract.tools) {
            if ($prohibitedTools -contains $tool.ToLower()) {
                $policyChecks += @{
                    check = "prohibited_tool"
                    passed = $false
                    detail = "Tool '$tool' is prohibited"
                }
            }
        }
    }
    # Check task type against policy
    $restrictedTaskTypes = @("system_modify", "network_configure", "security_alter")
    if ($restrictedTaskTypes -contains $Contract.task_type) {
        $policyChecks += @{
            check = "restricted_task_type"
            passed = $false
            detail = "Task type '$($Contract.task_type)' requires special authorization"
        }
    }
    $policyPassed = ($policyChecks | Where-Object { -not $_.passed }).Count -eq 0
    $result.evaluations.policy = @{
        valid = $policyPassed
        checks = $policyChecks
    }
    if (-not $policyPassed) {
        $failedCheck = $policyChecks | Where-Object { -not $_.passed } | Select-Object -First 1
        $result.reason = "Policy violation: $($failedCheck.detail)"
        return $result
    }

    # 5. Tools Verification
    $requiredTools = @()
    switch ($Contract.task_type) {
        "build" { $requiredTools = @("msbuild", "dotnet", "npm") }
        "test" { $requiredTools = @("pester", "pytest", "jest") }
        "deploy" { $requiredTools = @("kubectl", "docker", "helm") }
        default { $requiredTools = @() }
    }
    $toolsValid = $true
    if ($requiredTools.Count -gt 0) {
        $providedTools = @($Contract.tools)
        foreach ($reqTool in $requiredTools) {
            if (-not ($providedTools -contains $reqTool)) {
                $toolsValid = $false
                break
            }
        }
    }
    $result.evaluations.tools = @{
        valid = $toolsValid
        required = $requiredTools
        provided = $Contract.tools
    }
    if (-not $toolsValid) {
        $result.reason = "Missing required tools. Required: $($requiredTools -join ', ')"
        return $result
    }

    # 6. Engine Verification
    $engineType = $Contract.engine ?? $Contract.task_type
    $engineRegistry = Load-Yaml -Path (Join-Path $ScriptRoot '..\lab-engine\core\registry.yaml')
    if ($engineRegistry) {
        $engineValid = $engineRegistry.engines.ContainsKey($engineType)
        if (-not $engineValid) {
            # Check if it's mapped in decisions
            $engineValid = $engineRegistry.decisions | Where-Object {
                $_.task_pattern -eq $Contract.task_type -and
                $_.engine -eq $engineType
            }
        }
    } else {
        $engineValid = $true  # If we can't load registry, assume valid (will fail later in orchestrator)
    }
    $result.evaluations.engine = @{
        valid = $engineValid
        engine_type = $engineType
        registry_available = ($engineRegistry -ne $null)
    }
    if (-not $engineValid) {
        $result.reason = "Engine '$engineType' not found in registry or decisions"
        return $result
    }

    # All checks passed
    $result.allowed = $true
    $result.reason = "Task approved by governance"
    return $result
}

# Execute governance check
$governanceResult = Invoke-GovernanceCheck -Contract $taskContract -Truth $projectTruth -State $projectState

# Output result as JSON for consumption by orchestrator
$governanceResult | ConvertTo-Json -Depth 5
exit 0
