# Reference Execution Engine
# This is a minimal engine that simulates task execution by creating an output file and generating evidence.

param (
    [string]$TaskContractPath
)

# Function to generate a simple hash (for demonstration)
function Get-Hash {
    param([string]$Input)
    if (-not $Input) { return "" }
    # Use SHA256
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($Input)
    $hash = [System.Security.Cryptography.SHA256]::Create().ComputeHash($bytes)
    $builder = New-Object System.Text.StringBuilder
    foreach ($b in $hash) {
        $builder.Append($b.ToString("x2")) | Out-Null
    }
    return $builder.ToString()
}

# Load the task contract
if (-not (Test-Path $TaskContractPath)) {
    Write-Error "Task contract not found: $TaskContractPath"
    exit 1
}

$contract = Get-Content $TaskContractPath -Raw | ConvertFrom-Yaml

# Extract task details
$taskId = $contract.task_id
$objective = $contract.objective
$expectedOutput = $contract.expected_state # Assuming expected_state is a string description

# Simulate execution: create an output file in a temporary location
$outputDir = "$PWD\execution_output"
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}
$outputFile = Join-Path $outputDir "$taskId.output.txt"

# Write a simple output (in a real engine, this would be the actual work)
"Executed task: $objective" | Out-File -FilePath $outputFile -Encoding UTF8
"Timestamp: $(Get-Date -Format o)" | Add-Content -Path $outputFile
"Expected state: $expectedOutput" | Add-Content -Path $outputFile

# Read the output file to compute hash
$outputContent = Get-Content $outputFile -Raw
$outputHash = Get-Hash $outputContent

# Generate evidence
$evidence = @{
    task_id = $taskId
    engine = "reference"
    timestamp = (Get-Date -Format o)
    objective = $objective
    expected_state = $expectedOutput
    actual_state = "Output file created: $outputFile"
    output_hash = $outputHash
    output_file = $outputFile
    execution_result = "SUCCESS"
} | ConvertTo-Json -Depth 5

# Write evidence to a file
$evidenceDir = "$PWD\evidence"
if (-not (Test-Path $evidenceDir)) {
    New-Item -ItemType Directory -Path $evidenceDir | Out-Null
}
$evidenceFile = Join-Path $evidenceDir "$taskId.evidence.json"
$evidence | Out-File -FilePath $evidenceFile -Encoding UTF8

Write-Host "Reference engine executed task $taskId. Evidence saved to $evidenceFile"
exit 0