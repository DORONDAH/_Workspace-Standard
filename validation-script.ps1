# Validation script for Workspace Standard documentation and implementation consistency

Write-Host "Starting validation of Workspace Standard documentation and implementation..." -ForegroundColor Cyan

$errors = @()
$warnings = @()

# 1. Check that agent contracts exist and have required fields
Write-Host "`nChecking agent contracts..." -ForegroundColor Yellow
$agentContracts = Get-ChildItem -Path ".\agents" -Filter "*-contract.yaml"
if ($agentContracts.Count -eq 0) {
    $errors += "No agent contracts found in agents/ directory."
} else {
    foreach ($contract in $agentContracts) {
        Write-Host "  Checking $($contract.Name)..."
        $content = Get-Content $contract.FullName -Raw
        # Check for required fields
        $requiredFields = @("id:", "role:", "goal:", "authority:", "forbidden_actions:", "tools:", "tool_permissions:", "dependencies:", "failure_modes:", "escalation:", "validation_requirements:", "delegation_permissions:", "authorization_requirement:")
        foreach ($field in $requiredFields) {
            if ($content -notmatch [regex]::Escape($field)) {
                $errors += "Missing required field '$field' in $($contract.Name)"
            }
        }
        # Check that Supervisor does not execute
        if ($contract.Name -eq "supervisor-contract.yaml") {
            if ($content -match "Execute tasks") {
                $warnings += "Supervisor contract mentions executing tasks - should only authorize."
            }
        }
        # Check that Executor does not authorize
        if ($contract.Name -eq "executor-contract.yaml") {
            if ($content -match "Authorize tasks") {
                $warnings += "Executor contract mentions authorizing tasks - should only execute after authorization."
            }
        }
    }
}

# 2. Check that Control Plane scripts exist
Write-Host "`nChecking Control Plane scripts..." -ForegroundColor Yellow
$controlPlaneScripts = @(
    "control-plane.ps1",
    "State-Machine.ps1",
    "governance-enforcement.ps1",
    "validation-engine.ps1"
)
$controlPlaneDir = ".\control-plane"
foreach ($script in $controlPlaneScripts) {
    $scriptPath = Join-Path $controlPlaneDir $script
    if (-Not (Test-Path $scriptPath)) {
        $errors += "Control Plane script missing: $script"
    } else {
        Write-Host "  Found $script"
    }
}

# 3. Check that PROJECT-TRUTH.md and PROJECT-STATE.yaml exist and have been updated
Write-Host "`nChecking core documentation..." -ForegroundColor Yellow
$docFiles = @(
    "projects\workspace-standard\PROJECT-TRUTH.md",
    "projects\workspace-standard\PROJECT-STATE.yaml"
)
foreach ($doc in $docFiles) {
    if (-Not (Test-Path $doc)) {
        $errors += "Documentation file missing: $doc"
    } else {
        Write-Host "  Found $doc"
        # Check that PROJECT-TRUTH.md has Context Layers section
        if ($doc -like "*PROJECT-TRUTH.md") {
            $content = Get-Content $doc -Raw
            if ($content -notmatch "Context Layers") {
                $warnings += "PROJECT-TRUTH.md may be missing Context Layers section."
            }
        }
        # Check that PROJECT-STATE.yaml has been updated to reflect current phase
        if ($doc -like "*PROJECT-STATE.yaml") {
            $content = Get-Content $doc -Raw
            if ($content -notmatch 'phase: "PHASE_9"') {
                $warnings += "PROJECT-STATE.yaml may not be updated to reflect Phase 9."
            }
        }
    }
}

# 4. Check that agent contracts are consistent with Control Plane (basic check)
Write-Host "`nChecking consistency between agent contracts and Control Plane..." -ForegroundColor Yellow
# We'll do a simple check: ensure that the tools listed in agent contracts exist in Control Plane or are permitted
foreach ($contract in $agentContracts) {
    $content = Get-Content $contract.FullName -Raw
    # Extract tools section (simplistic)
    if ($content -match "tools:(.*?)tool_permissions:") {
        $toolsSection = $matches[1]
        # List of expected tools from Control Plane
        $expectedTools = @("control-plane.ps1", "State-Machine.ps1", "governance-enforcement.ps1", "validation-engine.ps1")
        foreach ($tool in $expectedTools) {
            if ($toolsSection -notmatch [regex]::Escape($tool)) {
                # It's okay if not all tools are listed, but we warn if a contract that should use them doesn't
                if ($contract.Name -like "*supervisor*" -or $contract.Name -like "*executor*") {
                    $warnings += "$($contract.Name) does not list $tool in tools section - may be missing."
                }
            }
        }
    }
}

# Output results
Write-Host "`n`n=== VALIDATION RESULTS ===" -ForegroundColor Green
if ($errors.Count -eq 0) {
    Write-Host "No errors found." -ForegroundColor Green
} else {
    Write-Host "Errors found:" -ForegroundColor Red
    foreach ($error in $errors) {
        Write-Host "  - $error" -ForegroundColor Red
    }
}
if ($warnings.Count -eq 0) {
    Write-Host "No warnings found." -ForegroundColor Green
} else {
    Write-Host "Warnings:" -ForegroundColor Yellow
    foreach ($warning in $warnings) {
        Write-Host "  - $warning" -ForegroundColor Yellow
    }
}

# Save results to a file
$reportPath = "VALIDATION-REPORT.md"
$report = "# Validation Report for Workspace Standard`n`n"
$report += "## Summary`n`n"
if ($errors.Count -eq 0) {
    $report += "Validation passed with no errors.`n`n"
} else {
    $report += "Validation failed with $($errors.Count) error(s).`n`n"
}
$report += "## Errors`n`n"
if ($errors.Count -eq 0) {
    $report += "No errors.`n`n"
} else {
    foreach ($error in $errors) {
        $report += "- $error`n"
    }
    $report += "`n"
}
$report += "## Warnings`n`n"
if ($warnings.Count -eq 0) {
    $report += "No warnings.`n`n"
} else {
    foreach ($warning in $warnings) {
        $report += "- $warning`n"
    }
    $report += "`n"
}
$report += "## Details`n`n"
$report += "- Agent contracts checked: $($agentContracts.Count)`n"
$report += "- Control Plane scripts checked: $($controlPlaneScripts.Count)`n"
$report += "- Documentation files checked: $($docFiles.Count)`n"
Set-Content -Path $reportPath -Value $report
Write-Host "`nValidation report saved to $reportPath" -ForegroundColor Cyan

exit $errors.Count