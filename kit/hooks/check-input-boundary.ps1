#Requires -Version 5.1
# Two things: the legacy Input API is refused outright, and input lifecycle
# mistakes are reported as warnings.
#
# The warnings do not block. An action map enabled but never disabled, or a
# callback subscribed but never removed, is a leak rather than a broken build -
# worth saying out loud, not worth refusing an edit over.

$ErrorActionPreference = "Stop"

try {
    $data = [Console]::In.ReadToEnd() | ConvertFrom-Json
}
catch {
    exit 0
}

$path = "$($data.tool_input.file_path)"
if ($path -notmatch '\.cs$') {
    exit 0
}

$content = $data.tool_input.new_string
if ([string]::IsNullOrEmpty($content)) {
    $content = $data.tool_input.content
}

if ([string]::IsNullOrEmpty($content)) {
    if (-not (Test-Path -LiteralPath $path)) {
        exit 0
    }

    $content = Get-Content -LiteralPath $path -Raw -ErrorAction SilentlyContinue
}

if ([string]::IsNullOrEmpty($content)) {
    exit 0
}

$stripped = $content -replace '//.*', '' -replace '"[^"]*"', '""'
$stripped = $stripped -replace '(?s)/\*.*?\*/', ''

$issues = New-Object System.Collections.Generic.List[string]
$blocking = $false

$legacy = '\bInput\.(GetKey|GetAxis|GetButton|GetMouseButton|mousePosition|touches|GetTouch|touchCount|anyKey|inputString)'
if ($stripped -match $legacy) {
    $issues.Add("BLOCKING - legacy Input API used; the project is on the Input System.")
    $blocking = $true
}

if ($path -match '[\\/](Core|Environment)[\\/]') {
    if ($stripped -match '\b(InputAction|InputActionAsset|PlayerControls|UnityEngine\.InputSystem)\b') {
        $issues.Add("BLOCKING - Input System dependency found in the Core/Environment layer.")
        $blocking = $true
    }
}

if ($path -notmatch '[\\/][Ee]ditor[\\/]') {
    $referencesInput = $stripped -match '(PlayerControls|InputActionAsset|InputAction\b|_controls\.|_inputActions\.)'

    if ($referencesInput) {
        if ($stripped -notmatch '\.(Enable|Player\.Enable|UI\.Enable)\(\)') {
            $issues.Add("WARNING - input controls referenced but no Enable() call found.")
        }

        if ($stripped -notmatch '\.(Disable|Player\.Disable|UI\.Disable)\(\)') {
            $issues.Add("WARNING - input controls referenced but no Disable() call found.")
        }

        $subscriptions = [regex]::Matches($stripped, '\+=\s*(On[A-Z]\w+)') |
            ForEach-Object { $_.Groups[1].Value } |
            Select-Object -Unique

        foreach ($callback in $subscriptions) {
            if ($stripped -notmatch "-=\s*$([regex]::Escape($callback))\b") {
                $issues.Add("WARNING - input callback '$callback' subscribed but never unsubscribed.")
            }
        }
    }
}

if ($issues.Count -eq 0) {
    exit 0
}

if ($blocking) {
    [Console]::Error.WriteLine("INPUT BOUNDARY ERROR in: $path")
}
else {
    [Console]::Error.WriteLine("Input boundary warnings in: $path")
}

foreach ($issue in $issues) {
    [Console]::Error.WriteLine("  $issue")
}

if ($blocking) {
    exit 2
}

exit 0
