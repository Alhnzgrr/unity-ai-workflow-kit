# Hooks

Guardrails for the Unity mistakes that cost the most to find late: corrupted
serialized files, editor code leaking into a player build, and architecture
boundaries eroding one shortcut at a time.

Each guardrail ships twice — `.ps1` for Windows and `.sh` for macOS and Linux —
with identical behaviour. `install-claude-adapter.ps1` installs the PowerShell
set into `.claude/hooks/` and wires it in `.claude/settings.json`. The bash
versions need `jq`; the PowerShell versions have no dependencies beyond
Windows PowerShell 5.1.

## Blocking

| Hook | Refuses |
| --- | --- |
| `block-serialized-unity-edit` | Text edits to `.unity`, `.prefab`, and `.asset` outside `Scripts/`, `Editor/` and `Plugins/`. Serialized references break silently under text editing; the Editor is the only safe writer. |
| `guard-editor-runtime` | `UnityEditor` in runtime code with no `#if UNITY_EDITOR`. The Editor assembly does not exist in a player build, so this compiles until someone makes a build. |
| `check-core-boundary` | `UnityEngine`, `MonoBehaviour`, `UnityEditor`, `InputAction` or `PlayerControls` inside `Core/` or `Environment/`. A Core layer earns its keep by being testable without play mode, and one `using` ends that. |
| `check-input-boundary` | The legacy `Input` API anywhere, and Input System types inside `Core/`. |

## Warning

| Hook | Reports |
| --- | --- |
| `check-input-boundary` | Action maps enabled but never disabled, and callbacks subscribed but never removed. Leaks rather than breakage, so they are said out loud rather than refused. |
| `warn-serialized-rename` | A `[SerializeField]` name that disappears from an edit without `[FormerlySerializedAs]` taking its place. Unity keys serialized data by name, so the old value is dropped and the field returns as the type default — nothing errors, and the bug shows up later as a zero. |

## Contract

Each hook reads a JSON tool payload on stdin and uses:

- `tool_input.file_path`
- `tool_input.new_string` / `tool_input.content`
- `tool_input.old_string` (rename detection only)

Exit codes: `0` allows the edit, `2` refuses it and returns the message on
stderr to the model. Malformed or empty input exits `0` — a guardrail that
cannot parse its input should get out of the way rather than block all work.

Comments and string literals are stripped before matching, so a rule mentioned
in prose does not trip its own check.

## Limits

These are guardrails, not static analysis. They match on paths and text, so a
project whose folders are not named `Core/` or `Environment/` needs the path
patterns adjusted. They are deliberately conservative: a false block is a
visible annoyance, while a false pass is invisible.
