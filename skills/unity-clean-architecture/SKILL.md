# Unity Clean Architecture Skill

## Purpose

Help AI assistants structure Unity projects with clean, maintainable architecture while staying practical for real game development.

## Core Idea

Unity code should not become a pile of giant MonoBehaviours.

Use MonoBehaviours for Unity integration, not as the default place for every rule.

## Recommended Layers

```text
Core/
  Pure C# models, enums, value objects, rules

Systems/
  Gameplay systems and application logic

Views/
  MonoBehaviours, UI bindings, animation triggers, input adapters

Data/
  ScriptableObjects, config assets, balance data

Installers/
  Dependency injection bindings when DI is used
```

## Core Rules

- Keep gameplay rules testable.
- Avoid direct Unity dependencies in core logic.
- Keep MonoBehaviours small.
- Prefer composition over inheritance.
- Use interfaces only when they define a meaningful boundary.
- Avoid manager classes that do everything.
- Keep dependencies explicit.

## Good Example

```text
PlayerInputView
  Reads Unity input and sends commands.

PlayerMovementSystem
  Calculates movement rules.

PlayerMovementView
  Applies movement result to Rigidbody or CharacterController.
```

## Bad Example

```text
PlayerController
  Reads input
  Moves player
  Handles health
  Updates UI
  Plays sounds
  Saves data
  Spawns VFX
  Talks to networking
```

## Dependency Direction

Prefer this direction:

```text
Views → Systems → Core
```

Core should not know about Views.

Systems should not depend on specific scene objects unless necessary.

## DI Guidance

Zenject can be used, but the architecture should not require Zenject to make sense.

Good DI usage:

- constructor injection for systems
- installers for bindings
- interfaces at useful boundaries

Avoid:

- injecting everything just because possible
- service locator patterns disguised as DI
- global containers accessed from gameplay logic

## When To Refactor

Refactor when:

- a class has multiple unrelated reasons to change
- a MonoBehaviour becomes hard to read
- a system cannot be tested without a scene
- adding a feature requires editing too many unrelated files
- dependencies are hidden or circular

## When Not To Refactor

Do not refactor just to apply a pattern.

Do not split a tiny feature into ten files if the boundaries are not clear yet.

Start simple, then improve when the shape of the system becomes obvious.
