#Requires -Version 5.1
# Blocks UnityEditor usage in runtime code that is not behind UNITY_EDITOR.
#
# The Editor assembly does not exist in a player build. Code that compiles in
# the Editor and fails only when someone makes a build is the expensive kind of
# mistake, because it is found last.

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

# Anything under an Editor folder is Editor-only by Unity's own rules.
if ($path -match '[\\/][Ee]ditor[\\/]') {
    exit 0
}

$content = $data.tool_input.new_string
if ([string]::IsNullOrEmpty($content)) {
    $content = $data.tool_input.content
}

if ([string]::IsNullOrEmpty($content)) {
    exit 0
}

# Strip comments and string literals so a mention in prose does not trip the check.
$stripped = $content -replace '//.*', '' -replace '"[^"]*"', '""'
$stripped = $stripped -replace '(?s)/\*.*?\*/', ''

if ($stripped -match '(using\s+UnityEditor|UnityEditor\.)') {
    if ($content -notmatch '#if\s+UNITY_EDITOR') {
        [Console]::Error.WriteLine("BLOCKED: UnityEditor usage found in runtime code without a UNITY_EDITOR guard.")
        [Console]::Error.WriteLine("File: $path")
        [Console]::Error.WriteLine("Move the code to an Editor folder or wrap it with #if UNITY_EDITOR.")
        exit 2
    }
}

exit 0
