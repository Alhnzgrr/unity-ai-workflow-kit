# Editor Runtime Separation Skill

## Purpose

Help AI assistants keep Unity editor tooling separate from runtime environment logic, simulation systems, and mobile-facing builds.

## Core Idea

Editor code is not runtime code.

In Unity projects like this one, editor helpers are useful for:

- scenario authoring
- config validation
- custom inspectors
- debug tooling
- data generation

But these should not leak into runtime systems or mobile builds.

## Main Rule

Anything that depends on `UnityEditor` must stay out of normal runtime code unless it is properly guarded.

## Good Separation

Keep these separate:

### Runtime

Owns:

- environment state
- action validation
- transition logic
- reward logic
- termination logic
- runtime views and adapters

### Editor

Owns:

- asset creation tools
- inspector helpers
- menu commands
- authoring-time validation
- data migration utilities

## Recommended Structure

Use:

- `Editor/` folders for editor-only code
- editor-only assemblies when possible
- guarded code only when editor functionality must live near runtime types

## Guarding Editor Usage

If editor code must exist next to runtime code, guard it:

```csharp
#if UNITY_EDITOR
using UnityEditor;
#endif
```

```csharp
private void OnValidate()
{
    #if UNITY_EDITOR
    EditorUtility.SetDirty(this);
    #endif
}
```

## Preferred Approach

Prefer true separation over heavy conditional compilation inside runtime files.

Good:

- custom inspectors in editor-only code
- asset generation tools in editor-only code
- authoring validators in editor assemblies

Less good:

- runtime classes filled with many editor-only branches

## Environment-Specific Guidance

In this project, editor tools may help with:

- generating scenario assets
- validating reward config
- checking environment setup
- building debug presets
- preparing replay or test fixtures

These tools should support the runtime environment, not become part of it.

## Runtime Safety Rules

- Runtime systems must not require editor APIs to function.
- Environment stepping must work in builds without editor code.
- Debug tooling should degrade safely in runtime builds.
- Authoring helpers should never become hidden runtime dependencies.

## Common Mistakes

- referencing `UnityEditor` from runtime systems
- putting environment validation logic only in editor code when runtime also depends on it
- assuming editor-only utilities will exist in device builds
- mixing authoring helpers with live environment logic
- using editor-only convenience code as a hidden runtime requirement

## AI Review Guidance

When reviewing editor/runtime separation, check:

- Is editor code cleanly separated?
- Could the runtime environment work in a player build without editor APIs?
- Are authoring helpers supporting runtime rather than leaking into it?
- Are `UNITY_EDITOR` guards used only where separation cannot be cleaner?
