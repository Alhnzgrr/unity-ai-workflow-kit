#Requires -Version 5.1
# Blocks direct text edits to serialized Unity files.
#
# Unity stores scenes, prefabs and assets as YAML full of fileIDs and GUIDs.
# A text edit that looks correct can silently break a reference, and the damage
# usually surfaces later, in a different file, as a missing script. The Editor
# is the only safe writer for these.

$ErrorActionPreference = "Stop"

try {
    $data = [Console]::In.ReadToEnd() | ConvertFrom-Json
}
catch {
    exit 0
}

$path = "$($data.tool_input.file_path)"
if ([string]::IsNullOrWhiteSpace($path)) {
    exit 0
}

if ($path -match '\.(unity|prefab)$') {
    [Console]::Error.WriteLine("BLOCKED: direct editing of Unity scene/prefab files is not allowed.")
    [Console]::Error.WriteLine("File: $path")
    [Console]::Error.WriteLine("Reason: serialized references are easy to corrupt with text edits.")
    [Console]::Error.WriteLine("Ask the user to make this change in the Unity Editor.")
    exit 2
}

if ($path -match '\.asset$') {
    # Scripts, Editor and Plugins folders hold .asset files that are settings
    # rather than authored content, so they stay editable.
    if ($path -match '[\\/](Scripts|Editor|Plugins)[\\/]') {
        exit 0
    }

    [Console]::Error.WriteLine("BLOCKED: direct editing of serialized .asset files is not allowed by default.")
    [Console]::Error.WriteLine("File: $path")
    [Console]::Error.WriteLine("Reason: authoring data and serialized references can break silently.")
    exit 2
}

exit 0
