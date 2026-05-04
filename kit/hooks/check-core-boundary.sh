#!/usr/bin/env bash
set -euo pipefail

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [ -z "$FILE_PATH" ]; then
    exit 0
fi

case "$FILE_PATH" in
    *.cs) ;;
    *) exit 0 ;;
esac

case "$FILE_PATH" in
    */Core/*|*/Environment/*)
        ;;
    *)
        exit 0
        ;;
esac

if [ ! -f "$FILE_PATH" ]; then
    exit 0
fi

if grep -nE 'using[[:space:]]+UnityEngine' "$FILE_PATH" >/dev/null 2>&1; then
    echo "BLOCKED: UnityEngine dependency found in Core/Environment layer." >&2
    echo "File: $FILE_PATH" >&2
    echo "Move Unity-facing behavior to Views, adapters, or composition code." >&2
    exit 2
fi

if grep -nE ':[[:space:]]*MonoBehaviour\b|\bMonoBehaviour\b' "$FILE_PATH" >/dev/null 2>&1; then
    echo "BLOCKED: MonoBehaviour usage found in Core/Environment layer." >&2
    echo "File: $FILE_PATH" >&2
    echo "Core and Environment layers should stay plain C# wherever possible." >&2
    exit 2
fi

if grep -nE '\b(UnityEditor|InputAction|PlayerControls)\b' "$FILE_PATH" >/dev/null 2>&1; then
    echo "BLOCKED: input/editor-specific dependency found in Core/Environment layer." >&2
    echo "File: $FILE_PATH" >&2
    echo "Keep input and editor concerns in adapters or view code." >&2
    exit 2
fi

exit 0
