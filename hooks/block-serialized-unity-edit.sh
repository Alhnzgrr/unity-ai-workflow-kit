#!/usr/bin/env bash
set -euo pipefail

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [ -z "$FILE_PATH" ]; then
    exit 0
fi

case "$FILE_PATH" in
    *.unity|*.prefab)
        echo "BLOCKED: direct editing of Unity scene/prefab files is not allowed." >&2
        echo "File: $FILE_PATH" >&2
        echo "Reason: serialized references are easy to corrupt with text edits." >&2
        exit 2
        ;;
    *.asset)
        case "$FILE_PATH" in
            */Scripts/*|*/Editor/*|*/Plugins/*)
                exit 0
                ;;
            *)
                echo "BLOCKED: direct editing of serialized .asset files is not allowed by default." >&2
                echo "File: $FILE_PATH" >&2
                echo "Reason: authoring data and serialized references can break silently." >&2
                exit 2
                ;;
        esac
        ;;
    *)
        exit 0
        ;;
esac
