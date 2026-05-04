param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectPath
)

$ErrorActionPreference = "Stop"

$projectRoot = Resolve-Path $ProjectPath
$targetKit = Join-Path $projectRoot "Assets\unity-ai-workflow-kit"

$requiredPaths = @(
    "AGENTS.md",
    "agents",
    "commands",
    "hooks",
    "rules",
    "skills",
    "templates",
    "workflows",
    "runtime\tasks",
    "runtime\handoffs",
    "runtime\reviews",
    "runtime\validations",
    "runtime\logs"
)

if (-not (Test-Path $targetKit)) {
    throw "Unity AI Workflow Kit is not installed at: $targetKit"
}

$missing = @()
foreach ($relativePath in $requiredPaths) {
    $fullPath = Join-Path $targetKit $relativePath
    if (-not (Test-Path $fullPath)) {
        $missing += $relativePath
    }
}

if ($missing.Count -gt 0) {
    Write-Host "Install validation failed. Missing paths:"
    foreach ($path in $missing) {
        Write-Host "- $path"
    }
    exit 1
}

Write-Host "Install validation passed: $targetKit"
