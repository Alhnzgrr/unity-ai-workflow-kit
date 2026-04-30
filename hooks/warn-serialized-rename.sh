#!/usr/bin/env bash
set -euo pipefail

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
OLD_STRING=$(echo "$INPUT" | jq -r '.tool_input.old_string // empty')
NEW_STRING=$(echo "$INPUT" | jq -r '.tool_input.new_string // empty')

case "$FILE_PATH" in
    *.cs) ;;
    *) exit 0 ;;
esac

if [ -z "$OLD_STRING" ] || [ -z "$NEW_STRING" ]; then
    exit 0
fi

OLD_FIELDS=$(echo "$OLD_STRING" | grep -oE '\[SerializeField\].*\s+([_a-zA-Z][_a-zA-Z0-9]*)\s*[;=]' | grep -oE '[_a-zA-Z][_a-zA-Z0-9]*\s*[;=]' | sed 's/[;= ]//g' || true)
NEW_FIELDS=$(echo "$NEW_STRING" | grep -oE '\[SerializeField\].*\s+([_a-zA-Z][_a-zA-Z0-9]*)\s*[;=]' | grep -oE '[_a-zA-Z][_a-zA-Z0-9]*\s*[;=]' | sed 's/[;= ]//g' || true)

if [ -z "$OLD_FIELDS" ] || [ -z "$NEW_FIELDS" ]; then
    exit 0
fi

for OLD_FIELD in $OLD_FIELDS; do
    if ! echo "$NEW_FIELDS" | grep -qx "$OLD_FIELD"; then
        if ! echo "$NEW_STRING" | grep -q "FormerlySerializedAs.*\"$OLD_FIELD\""; then
            echo "WARNING: serialized field '$OLD_FIELD' appears to have been renamed without [FormerlySerializedAs]." >&2
            echo "File: $FILE_PATH" >&2
            echo "Add [FormerlySerializedAs(\"$OLD_FIELD\")] if this rename affects existing assets or prefabs." >&2
            echo "" >&2
        fi
    fi
done

exit 0
