<#
.SYNOPSIS
    Installs the Claude Code adapter into a Unity project.

.DESCRIPTION
    Writes the four things Claude Code actually reads:

      CLAUDE.md              project instructions
      .claude/agents/        the kit's reviewer and implementer agents
      .claude/commands/      the kit's slash commands
      .claude/hooks/         the PowerShell guardrails
      .claude/settings.json  wires those hooks onto Write and Edit

    Earlier versions copied CLAUDE.md alone, so the rules shipped as advice and
    nothing enforced them. Hooks are the part that cannot be argued with, which
    is the whole point of the kit.

    Re-running is safe: kit-owned hook entries are replaced rather than appended,
    and any settings.json already in the project is backed up first.
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectPath
)

$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$sourceAdapter = Join-Path $repoRoot "adapters\claude"
$sourceKit = Join-Path $repoRoot "kit"
$projectRoot = Resolve-Path $ProjectPath

if (-not (Test-Path (Join-Path $projectRoot "Assets"))) {
    throw "ProjectPath must point to a Unity project with an Assets folder: $ProjectPath"
}

$claudeDir = Join-Path $projectRoot ".claude"
New-Item -ItemType Directory -Force $claudeDir | Out-Null

# --- project instructions -------------------------------------------------
Copy-Item (Join-Path $sourceAdapter "CLAUDE.md") (Join-Path $projectRoot "CLAUDE.md") -Force
Write-Host "  CLAUDE.md"

# --- agents, commands, hooks ----------------------------------------------
function Copy-KitFolder {
    param(
        [string]$SourceFolder,
        [string]$TargetFolder,
        [string]$Filter,
        [string]$Label
    )

    if (-not (Test-Path $SourceFolder)) {
        return
    }

    $files = @(Get-ChildItem -Path $SourceFolder -Filter $Filter -File)
    if ($files.Count -eq 0) {
        return
    }

    New-Item -ItemType Directory -Force $TargetFolder | Out-Null
    foreach ($file in $files) {
        Copy-Item $file.FullName $TargetFolder -Force
    }

    Write-Host ("  {0,-22} {1} file(s)" -f $Label, $files.Count)
}

Copy-KitFolder -SourceFolder (Join-Path $sourceKit "agents") `
               -TargetFolder (Join-Path $claudeDir "agents") `
               -Filter "*.md" -Label ".claude/agents"

Copy-KitFolder -SourceFolder (Join-Path $sourceKit "commands") `
               -TargetFolder (Join-Path $claudeDir "commands") `
               -Filter "*.md" -Label ".claude/commands"

# Only the PowerShell hooks are installed here. The .sh versions are the same
# guardrails for macOS and Linux, and they need jq; settings.json below invokes
# the .ps1 ones.
Copy-KitFolder -SourceFolder (Join-Path $sourceKit "hooks") `
               -TargetFolder (Join-Path $claudeDir "hooks") `
               -Filter "*.ps1" -Label ".claude/hooks"

# --- settings.json --------------------------------------------------------
$kitSettingsPath = Join-Path $sourceAdapter "settings.json"
$targetSettingsPath = Join-Path $claudeDir "settings.json"

$kitSettings = Get-Content $kitSettingsPath -Raw | ConvertFrom-Json
$kitMatchers = @($kitSettings.hooks.PreToolUse)

if (-not (Test-Path $targetSettingsPath)) {
    Copy-Item $kitSettingsPath $targetSettingsPath -Force
    Write-Host "  .claude/settings.json  created"
}
else {
    $backup = "$targetSettingsPath.bak"
    Copy-Item $targetSettingsPath $backup -Force

    $existing = Get-Content $targetSettingsPath -Raw | ConvertFrom-Json

    if ($null -eq $existing.hooks) {
        $existing | Add-Member -NotePropertyName hooks -NotePropertyValue ([PSCustomObject]@{}) -Force
    }

    # Drop anything this kit installed before, so re-running does not stack
    # duplicate matchers, then append the current set.
    $keep = @()
    if ($null -ne $existing.hooks.PreToolUse) {
        foreach ($entry in @($existing.hooks.PreToolUse)) {
            $isKitEntry = $false
            foreach ($hook in @($entry.hooks)) {
                if ("$($hook.command)" -match '\.claude/hooks/') {
                    $isKitEntry = $true
                    break
                }
            }

            if (-not $isKitEntry) {
                $keep += $entry
            }
        }
    }

    $existing.hooks | Add-Member -NotePropertyName PreToolUse `
        -NotePropertyValue (@($keep) + $kitMatchers) -Force

    $existing | ConvertTo-Json -Depth 20 | Set-Content $targetSettingsPath -Encoding utf8
    Write-Host "  .claude/settings.json  merged (previous version kept at settings.json.bak)"
}

Write-Host ""
Write-Host "Installed Claude adapter to: $projectRoot"
Write-Host "Run scripts\validate-install.ps1 -ProjectPath `"$projectRoot`" to check it."
