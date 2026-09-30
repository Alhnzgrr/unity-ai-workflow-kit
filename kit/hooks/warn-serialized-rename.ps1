#Requires -Version 5.1
# Warns when a [SerializeField] name disappears from an edit without
# [FormerlySerializedAs] taking its place.
#
# Renaming a serialized field is how a prefab quietly loses a value: Unity keys
# serialized data by name, so the old value is dropped and the field comes back
# as the type default. Nothing errors. The bug shows up as a zero somewhere.
#
# A warning, not a block: the rename is often correct, and the hook cannot know
# whether any asset actually holds a value for that field.

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

$oldString = "$($data.tool_input.old_string)"
$newString = "$($data.tool_input.new_string)"

if ([string]::IsNullOrWhiteSpace($oldString) -or [string]::IsNullOrWhiteSpace($newString)) {
    exit 0
}

function Get-SerializedFieldNames {
    param([string]$Text)

    $pattern = '\[SerializeField\][^;]*?([_a-zA-Z][_a-zA-Z0-9]*)\s*[;=]'
    return [regex]::Matches($Text, $pattern, 'Singleline') |
        ForEach-Object { $_.Groups[1].Value } |
        Select-Object -Unique
}

$oldFields = @(Get-SerializedFieldNames -Text $oldString)
$newFields = @(Get-SerializedFieldNames -Text $newString)

if ($oldFields.Count -eq 0 -or $newFields.Count -eq 0) {
    exit 0
}

foreach ($field in $oldFields) {
    if ($newFields -contains $field) {
        continue
    }

    if ($newString -match "FormerlySerializedAs\s*\(\s*""$([regex]::Escape($field))""") {
        continue
    }

    [Console]::Error.WriteLine("WARNING: serialized field '$field' looks renamed without [FormerlySerializedAs].")
    [Console]::Error.WriteLine("File: $path")
    [Console]::Error.WriteLine("Add [FormerlySerializedAs(""$field"")] if any prefab or asset holds a value for it.")
    [Console]::Error.WriteLine("")
}

exit 0
