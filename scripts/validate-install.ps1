<#
.SYNOPSIS
    Checks that the kit and, if present, the Claude adapter are wired correctly.

.DESCRIPTION
    Reports two things separately:

      Kit       the reference content copied into Assets/unity-ai-workflow-kit
      Adapter   the files an AI tool actually reads, and whether the hooks in
                settings.json point at scripts that exist

    The second half is the one that matters. Rules that are present but not
    wired are documentation, and the earlier installer shipped exactly that.
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$ProjectPath
)

$ErrorActionPreference = "Stop"

$projectRoot = Resolve-Path $ProjectPath
$targetKit = Join-Path $projectRoot "Assets\unity-ai-workflow-kit"
$claudeDir = Join-Path $projectRoot ".claude"

$failures = @()
$warnings = @()

# --- kit ------------------------------------------------------------------
Write-Host "Kit"

if (-not (Test-Path $targetKit)) {
    Write-Host "  not installed at $targetKit"
    $failures += "kit missing"
}
else {
    $requiredPaths = @(
        "AGENTS.md", "agents", "commands", "hooks", "rules", "skills",
        "templates", "workflows",
        "runtime\tasks", "runtime\handoffs", "runtime\reviews",
        "runtime\validations", "runtime\logs"
    )

    foreach ($relativePath in $requiredPaths) {
        if (-not (Test-Path (Join-Path $targetKit $relativePath))) {
            $failures += "kit: $relativePath"
        }
    }

    Write-Host "  $targetKit"
    Write-Host ("  {0} of {1} expected paths present" -f `
        ($requiredPaths.Count - @($failures | Where-Object { $_ -like "kit: *" }).Count), $requiredPaths.Count)
}

# --- adapter --------------------------------------------------------------
Write-Host ""
Write-Host "Claude adapter"

if (-not (Test-Path $claudeDir)) {
    Write-Host "  not installed - run scripts\install-claude-adapter.ps1"
    $warnings += "no .claude directory"
}
else {
    foreach ($pair in @(
        @{ Path = (Join-Path $projectRoot "CLAUDE.md"); Label = "CLAUDE.md" },
        @{ Path = (Join-Path $claudeDir "agents");      Label = ".claude/agents" },
        @{ Path = (Join-Path $claudeDir "commands");    Label = ".claude/commands" },
        @{ Path = (Join-Path $claudeDir "hooks");       Label = ".claude/hooks" }
    )) {
        if (Test-Path $pair.Path) {
            $count = if ((Get-Item $pair.Path).PSIsContainer) {
                " ({0} files)" -f @(Get-ChildItem $pair.Path -File).Count
            } else { "" }
            Write-Host ("  present  {0}{1}" -f $pair.Label, $count)
        }
        else {
            Write-Host ("  MISSING  {0}" -f $pair.Label)
            $failures += "adapter: $($pair.Label)"
        }
    }

    # The check worth having: every hook command in settings.json must resolve
    # to a file. A path typo here fails silently at runtime - the tool call is
    # simply never guarded, and nothing says so.
    $settingsPath = Join-Path $claudeDir "settings.json"
    if (-not (Test-Path $settingsPath)) {
        Write-Host "  MISSING  .claude/settings.json - hooks are not wired"
        $failures += "adapter: settings.json"
    }
    else {
        $settings = Get-Content $settingsPath -Raw | ConvertFrom-Json
        $commands = @()

        foreach ($entry in @($settings.hooks.PreToolUse)) {
            foreach ($hook in @($entry.hooks)) {
                $commands += "$($hook.command)"
            }
        }

        if ($commands.Count -eq 0) {
            Write-Host "  MISSING  no PreToolUse hooks in settings.json"
            $failures += "adapter: no hooks wired"
        }
        else {
            $broken = 0
            foreach ($command in $commands) {
                if ($command -match '([^\s"]+\.(ps1|sh))') {
                    $scriptPath = Join-Path $projectRoot $Matches[1]
                    if (-not (Test-Path $scriptPath)) {
                        Write-Host ("  BROKEN   hook points at a missing file: {0}" -f $Matches[1])
                        $broken++
                    }
                }
            }

            if ($broken -eq 0) {
                Write-Host ("  present  .claude/settings.json ({0} hooks, all resolve)" -f $commands.Count)
            }
            else {
                $failures += "adapter: $broken hook path(s) do not resolve"
            }
        }
    }
}

# --- result ---------------------------------------------------------------
Write-Host ""

foreach ($warning in $warnings) {
    Write-Host "warning: $warning"
}

if ($failures.Count -gt 0) {
    Write-Host "Validation FAILED:"
    foreach ($failure in $failures) {
        Write-Host "  - $failure"
    }
    exit 1
}

Write-Host "Validation passed."
# Explicit, so a caller reading $LASTEXITCODE or %ERRORLEVEL% does not read a
# value left behind by whatever ran before this script.
exit 0
