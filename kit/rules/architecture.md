# Architecture Rules

## Core Principle

All non-trivial Unity features should preserve explicit boundaries between authoritative logic and presentation.

The default structure is:

```text
Core         - pure state, value objects, rule primitives
Environment  - rule execution, transitions, validation, orchestration
Views        - MonoBehaviours, UI, input adapters, visual feedback
Data         - ScriptableObject config and authored assets
Composition  - dependency registration and scene wiring
```

## Authoritative State

- Authoritative state lives in plain C# types.
- Views do not own game or environment truth.
- UI, animation, FX, and scene objects reflect state. They do not define it.

## View Boundaries

- Views may render, forward input, and react to state changes.
- Views may not contain rule logic, reward logic, or environment transition logic.
- Views may not decide legal versus illegal actions.

## Environment Boundaries

- Environment and system classes apply rules and mutate authoritative state.
- Environment code should stay as free from Unity scene concerns as practical.
- If a Unity-specific adapter is necessary, keep it at the boundary instead of leaking it into rule logic.

## Composition Boundaries

- Dependency registration belongs in composition code only.
- Composition is responsible for wiring state, systems, services, and views.
- Composition is not a service locator and not a runtime god object.

## Recommended Feature Shape

```text
FeatureConfig
  Authored data and tuning values.

FeatureState
  Runtime state and derived facts.

FeatureValidationSystem
  Decides whether an action is legal.

FeatureTransitionSystem
  Applies authoritative state change.

FeatureView
  Renders the current state and forwards user or agent interaction.

FeatureInstaller / LifetimeScope
  Wires dependencies explicitly.
```

## Rules

- Do not collapse a feature into one MonoBehaviour.
- Do not let scene objects become the source of truth.
- Do not mix config, runtime state, and visual state in one type.
- Keep environment transitions explicit and reviewable.
- Prefer simple structures first, but keep the boundaries production-safe.

## Common Mistakes

- putting validation logic in button handlers or view callbacks
- mutating authoritative state directly from UI code
- letting animation timing decide rule outcomes
- hiding architecture behind catch-all manager classes

## AI Review Guidance

When reviewing architecture, check:

- Is authoritative state separate from views?
- Is rule execution separate from rendering?
- Is composition explicit?
- Are config, runtime state, and visuals clearly separated?
