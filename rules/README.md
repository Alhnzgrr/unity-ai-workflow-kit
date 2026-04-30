# Rules

This folder defines the non-negotiable engineering rules for AI-assisted Unity development in this kit.

These files are not general suggestions.

They are intended to act as project rules that keep architecture, runtime behavior, and Unity-specific safety constraints consistent across generated code and reviews.

## Current Rule Set

- `architecture.md`
- `dependency-injection.md`
- `async.md`
- `unity-runtime.md`
- `serialization.md`
- `performance.md`

## How To Use

Load only the rules relevant to the current task.

Examples:

- new system design: `architecture.md` + `dependency-injection.md`
- async feature or delayed flow: `async.md`
- scene object setup or runtime MonoBehaviour work: `unity-runtime.md`
- inspector field rename or prefab-sensitive change: `serialization.md`
- optimization or mobile-sensitive work: `performance.md`

## Rule Intent

These rules are intentionally opinionated.

They enforce:

- explicit dependency wiring
- no scene search fallbacks
- UniTask-only async
- strict editor/runtime separation
- serialization safety
- production-minded performance discipline
