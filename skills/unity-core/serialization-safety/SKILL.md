# Serialization Safety Skill

## Purpose

Help AI assistants make Unity data structures safe to evolve without silently breaking serialized assets, scene references, or authoring workflows.

## Core Idea

Unity serialization is convenient but fragile.

Renaming fields, changing types, or mixing runtime state with serialized data can break:

- ScriptableObject configs
- scenario assets
- prefab references
- inspector-authored values

This project depends on stable authorable data, so serialization changes must be treated carefully.

## What Must Be Protected

Protect:

- ScriptableObject config assets
- scenario definitions
- serialized MonoBehaviour references
- inspector-exposed tuning values
- replay/debug config assets

## Main Rule

If a serialized field already exists in assets or prefabs, changing it is not free.

Before renaming, removing, or changing type, assume data migration impact exists.

## Safe Field Practices

- Use `[SerializeField] private` for Inspector-facing data.
- Keep serialized field names stable.
- Prefer narrow, focused serialized data types.
- Avoid serializing runtime-only caches and temporary state.

## Renaming Serialized Fields

If a serialized field must be renamed, use `FormerlySerializedAs`.

```csharp
using UnityEngine;
using UnityEngine.Serialization;

public sealed class ScenarioConfig : ScriptableObject
{
    [FormerlySerializedAs("_maxMoves")]
    [SerializeField] private int _maxStepCount;
}
```

Without this, Unity may lose the previously stored value in existing assets.

## Runtime State Rule

Do not serialize values only needed during the active episode unless there is a specific reason.

Examples of values that usually should not be serialized:

- current step count
- temporary legality cache
- live reward accumulator
- runtime references created during play

These belong in runtime state objects, not serialized fields.

## Type Change Caution

Be careful when changing:

- field type
- collection type
- nested serializable class layout
- enum values used by assets

These changes can invalidate existing data or reinterpret it unexpectedly.

## ScriptableObject Guidance

For ScriptableObjects:

- keep authorable fields explicit and stable
- avoid hidden mutable state
- avoid mixing config and runtime mutation
- treat asset schema changes as migration-sensitive

## MonoBehaviour Guidance

For MonoBehaviours:

- serialize scene/prefab references that must be wired in Inspector
- do not serialize internal caches just for convenience
- avoid renaming widely used serialized fields casually

## Null and Missing Data Awareness

When working with serialized references:

- assume references can be missing
- validate required references early
- provide clear failure behavior for missing config

Do not trust the Inspector blindly just because a field is serialized.

## Review Checklist

When changing serialized structures, ask:

- Is this field already present in existing assets or prefabs?
- Will renaming break stored data?
- Should `FormerlySerializedAs` be added?
- Is this value truly authorable, or is it runtime-only?
- Would this change require asset migration or validation?

## Common Mistakes

- renaming serialized fields without migration support
- serializing runtime-only state
- changing enum semantics without considering asset data
- putting too much unrelated data in one serialized type
- assuming broken references will be obvious immediately

## AI Review Guidance

When reviewing serialization safety, check:

- Are serialized fields stable and intentional?
- Are runtime-only values kept out of serialization?
- Are renames protected with migration attributes when needed?
- Could this change silently break existing assets or prefabs?
