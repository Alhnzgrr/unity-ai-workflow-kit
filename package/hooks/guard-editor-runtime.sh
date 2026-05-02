#!/usr/bin/env bash
set -euo pipefail

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
NEW_CONTENT=$(echo "$INPUT" | jq -r '.tool_input.new_string // .tool_input.content // empty')

case "$FILE_PATH" in
    *.cs) ;;
    *) exit 0 ;;
esac

case "$FILE_PATH" in
    */Editor/*|*/editor/*)
        exit 0
        ;;
esac

if [ -z "$NEW_CONTENT" ]; then
    exit 0
fi

STRIPPED_CONTENT=$(echo "$NEW_CONTENT" | sed 's|//.*||g; s/"[^"]*"/""/g' | sed ':a;N;$!ba;s|/\*[^*]*\*\+\([^/*][^*]*\*\+\)*/||g')

if echo "$STRIPPED_CONTENT" | grep -qE '(using[[:space:]]+UnityEditor|UnityEditor\.)'; then
    if ! echo "$NEW_CONTENT" | grep -qE '#if[[:space:]]+UNITY_EDITOR'; then
        echo "BLOCKED: UnityEditor usage found in runtime code without UNITY_EDITOR guard." >&2
        echo "File: $FILE_PATH" >&2
        echo "Move the code to an Editor folder or wrap it with #if UNITY_EDITOR." >&2
        exit 2
    fi
fi

exit 0
