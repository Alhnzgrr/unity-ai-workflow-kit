#Requires -Version 5.1
# Keeps the Core and Environment layers free of Unity-facing dependencies.
#
# The value of a Core layer is that it can be reasoned about, and tested, without
# an Editor or a play mode. One `using UnityEngine` is enough to lose that, and it
# is never added deliberately - it arrives as the shortest way to finish a task.

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

if ($path -notmatch '[\\/](Core|Environment)[\\/]') {
    exit 0
}

# Prefer the content being written; fall back to the file for edits that only
# change part of it.
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

$violations = @(
    @{ Pattern = 'using\s+UnityEngine';
       Message = 'UnityEngine dependency found in the Core/Environment layer.';
       Fix     = 'Move Unity-facing behaviour to views, adapters or composition code.' },

    @{ Pattern = '\bMonoBehaviour\b';
       Message = 'MonoBehaviour usage found in the Core/Environment layer.';
       Fix     = 'Core and Environment should stay plain C#.' },

    @{ Pattern = '\b(UnityEditor|InputAction|PlayerControls)\b';
       Message = 'Input or editor dependency found in the Core/Environment layer.';
       Fix     = 'Keep input and editor concerns in adapters or view code.' }
)

foreach ($violation in $violations) {
    if ($stripped -match $violation.Pattern) {
        [Console]::Error.WriteLine("BLOCKED: $($violation.Message)")
        [Console]::Error.WriteLine("File: $path")
        [Console]::Error.WriteLine($violation.Fix)
        exit 2
    }
}

exit 0
