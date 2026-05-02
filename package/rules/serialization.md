# Serialization Rules

## FormerlySerializedAs Is Mandatory

When renaming a serialized field, add `FormerlySerializedAs`.

This protects:

- scene values
- prefab values
- ScriptableObject asset values
- prefab overrides

## Non-Negotiable Rule

Do not rename serialized fields casually.

If a serialized field name changes and migration is needed, the migration marker stays in place.

## Serialized Data vs Runtime State

- serialized fields are for authored configuration and intentional Unity object references
- runtime state should not be serialized just because it exists
- internal flags, caches, and temporary state should stay plain private fields unless there is a real serialization reason

## Inspector Discipline

- prefer `[SerializeField] private`
- do not expose public fields just to make setup easier
- do not serialize speculative fields that are not actually authored

## Polymorphic Data

If the project needs interface or abstract-type serialization, use explicit Unity-safe patterns such as `SerializeReference` and review the tradeoffs carefully.

## Prefab Safety

- prefab instance overrides matter
- config assets matter
- silent reset is a real production cost

Serialization changes should be treated as data migration work, not casual refactor cleanup.

## Common Mistakes

- renaming inspector-backed fields without migration
- serializing runtime caches
- exposing fields publicly for convenience
- forgetting that inspector values are part of production data

## AI Review Guidance

When reviewing serialization-sensitive code, check:

- Was a serialized field renamed?
- If yes, was `FormerlySerializedAs` added?
- Is runtime state being serialized without reason?
- Could this change silently reset prefab or asset data?
