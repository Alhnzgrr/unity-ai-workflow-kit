# Hooks

This folder contains repository guardrails for Unity-specific risks.

The goal of these hooks is to catch high-cost mistakes early, especially around:

- serialized Unity file corruption
- editor/runtime leakage
- core architecture boundary violations

## Phase 1 Hooks

- `block-serialized-unity-edit.sh`
  Blocks direct text editing of serialized Unity scene, prefab, and selected asset files.

- `guard-editor-runtime.sh`
  Blocks `UnityEditor` usage in runtime code when it is not properly isolated.

- `check-core-boundary.sh`
  Protects `Core` and `Environment` layers from inappropriate Unity-facing dependencies.

## Phase 2 Hooks

- `warn-serialized-rename.sh`
  Warns when serialized fields appear to be renamed without migration support.

- `check-input-boundary.sh`
  Protects the project from input-layer leakage into `Core` and `Environment`, and warns about unsafe input lifecycle patterns.

## Input Format

These scripts are written to accept JSON on stdin, similar to tool hook payloads used by agent runtimes.

Expected useful fields include:

- `tool_input.file_path`
- `tool_input.new_string`
- `tool_input.content`

## Exit Codes

- `0`: allow / no issue
- `2`: blocking violation

## Notes

- Current hooks are intentionally conservative.
- Some rules may need path adjustments once the final project folder layout is fixed.
- These hooks are guardrails, not perfect static analyzers.
