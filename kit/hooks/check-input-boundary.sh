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

if [ ! -f "$FILE_PATH" ]; then
    exit 0
fi

STRIPPED=$(sed 's|//.*||g; s/"[^"]*"/""/g' "$FILE_PATH" 2>/dev/null | sed ':a;N;$!ba;s|/\*[^*]*\*\+\([^/*][^*]*\*\+\)*/||g')

ISSUES=""
BLOCKING=false

# Legacy Input API is always blocked.
LEGACY_INPUT=$(echo "$STRIPPED" | grep -nE '\bInput\.(GetKey|GetAxis|GetButton|GetMouseButton|mousePosition|touches|GetTouch|touchCount|anyKey|inputString)\b' || true)
if [ -n "$LEGACY_INPUT" ]; then
    ISSUES="${ISSUES}\nBLOCKING - Legacy Input API detected:\n${LEGACY_INPUT}\n"
    BLOCKING=true
fi

# Core/Environment should not know about InputAction or generated controls.
case "$FILE_PATH" in
    */Core/*|*/Environment/*)
        INPUT_BOUNDARY_VIOLATION=$(echo "$STRIPPED" | grep -nE '\b(InputAction|InputActionAsset|PlayerControls|UnityEngine\.InputSystem)\b' || true)
        if [ -n "$INPUT_BOUNDARY_VIOLATION" ]; then
            ISSUES="${ISSUES}\nBLOCKING - Input-system dependency found in Core/Environment layer:\n${INPUT_BOUNDARY_VIOLATION}\n"
            BLOCKING=true
        fi
        ;;
esac

# Warn about missing enable/disable if PlayerControls or InputAction are used in runtime view/adapter code.
case "$FILE_PATH" in
    */Editor/*|*/editor/*)
        ;;
    *)
        HAS_INPUT_REF=$(echo "$STRIPPED" | grep -cE '(PlayerControls|InputActionAsset|InputAction\b|_controls\.|_inputActions\.)' || true)
        if [ "${HAS_INPUT_REF:-0}" -gt 0 ]; then
            HAS_ENABLE=$(echo "$STRIPPED" | grep -cE '\.(Enable|Player\.Enable|UI\.Enable)\(\)' || true)
            HAS_DISABLE=$(echo "$STRIPPED" | grep -cE '\.(Disable|Player\.Disable|UI\.Disable)\(\)' || true)

            if [ "${HAS_ENABLE:-0}" -eq 0 ]; then
                ISSUES="${ISSUES}\nWARNING - Input controls referenced but no Enable() call found.\n"
            fi

            if [ "${HAS_DISABLE:-0}" -eq 0 ]; then
                ISSUES="${ISSUES}\nWARNING - Input controls referenced but no Disable() call found.\n"
            fi

            SUBSCRIBES=$(echo "$STRIPPED" | grep -oE '\+= On[A-Z]\w+' | sed 's/+= //' | sort -u || true)
            if [ -n "$SUBSCRIBES" ]; then
                for CALLBACK in $SUBSCRIBES; do
                    UNSUB_COUNT=$(echo "$STRIPPED" | grep -cE -- "-= ${CALLBACK}\b" || true)
                    if [ "${UNSUB_COUNT:-0}" -eq 0 ]; then
                        ISSUES="${ISSUES}\nWARNING - Input callback '${CALLBACK}' subscribed but never unsubscribed.\n"
                    fi
                done
            fi
        fi
        ;;
esac

if [ -n "$ISSUES" ]; then
    if [ "$BLOCKING" = true ]; then
        echo "INPUT BOUNDARY ERROR in: $FILE_PATH" >&2
        echo -e "$ISSUES" >&2
        exit 2
    fi

    echo "Input boundary warnings in: $FILE_PATH" >&2
    echo -e "$ISSUES" >&2
fi

exit 0
