param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectPath
)

$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$sourceAdapter = Join-Path $repoRoot "adapters\claude"
$projectRoot = Resolve-Path $ProjectPath

Copy-Item (Join-Path $sourceAdapter "CLAUDE.md") (Join-Path $projectRoot "CLAUDE.md") -Force

$sourceCommands = Join-Path $sourceAdapter "commands"
$targetCommands = Join-Path $projectRoot ".claude\commands"

if (Test-Path $sourceCommands) {
    New-Item -ItemType Directory -Force $targetCommands | Out-Null
    Get-ChildItem $sourceCommands | ForEach-Object {
        Copy-Item $_.FullName $targetCommands -Recurse -Force
    }
}

Write-Host "Installed Claude adapter to: $projectRoot"
