param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectPath
)

$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$sourceKit = Join-Path $repoRoot "kit"
$projectRoot = Resolve-Path $ProjectPath
$assetsPath = Join-Path $projectRoot "Assets"
$targetKit = Join-Path $assetsPath "unity-ai-workflow-kit"

if (-not (Test-Path $assetsPath)) {
    throw "ProjectPath must point to a Unity project with an Assets folder: $ProjectPath"
}

New-Item -ItemType Directory -Force $targetKit | Out-Null

Get-ChildItem $sourceKit | Where-Object { $_.Name -ne "runtime-template" } | ForEach-Object {
    Copy-Item $_.FullName $targetKit -Recurse -Force
}

$runtimeTemplate = Join-Path $sourceKit "runtime-template"
$runtimePath = Join-Path $targetKit "runtime"

if (Test-Path $runtimeTemplate) {
    New-Item -ItemType Directory -Force $runtimePath | Out-Null
    Get-ChildItem $runtimeTemplate | ForEach-Object {
        Copy-Item $_.FullName $runtimePath -Recurse -Force
    }
}

Write-Host "Installed Unity AI Workflow Kit to: $targetKit"
