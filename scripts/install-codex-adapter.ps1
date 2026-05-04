param(
    [string]$CodexHome = (Join-Path $env:USERPROFILE ".codex")
)

$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$sourceAdapter = Join-Path $repoRoot "adapters\codex"
$targetAdapter = Join-Path $CodexHome "skills\unity-ai-workflow-kit"

New-Item -ItemType Directory -Force $targetAdapter | Out-Null
Copy-Item (Join-Path $sourceAdapter "*") $targetAdapter -Recurse -Force

Write-Host "Installed Codex adapter to: $targetAdapter"
