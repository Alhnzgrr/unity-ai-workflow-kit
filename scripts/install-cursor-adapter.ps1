param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectPath
)

$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$sourceRules = Join-Path $repoRoot "adapters\cursor\rules"
$projectRoot = Resolve-Path $ProjectPath
$targetRules = Join-Path $projectRoot ".cursor\rules"

New-Item -ItemType Directory -Force $targetRules | Out-Null
Copy-Item (Join-Path $sourceRules "*") $targetRules -Recurse -Force

Write-Host "Installed Cursor adapter to: $targetRules"
