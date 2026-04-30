# Dependency Injection Rules

## Approved DI Options

Dependency injection is mandatory for non-trivial systems.

Approved containers:

- `VContainer`
- `Zenject`

## Project Rule

Choose one container per project.

Do not mix `VContainer` and `Zenject` in the same project architecture.

Once a project chooses one, all dependency wiring should follow that container's conventions consistently.

## Non-Negotiable Rules

- No `GameObject.Find`
- No `FindObjectOfType`
- No `FindAnyObjectByType`
- No `GetComponentInChildren` or hierarchy search as a fallback for missing required dependencies
- No `null` check in `Awake`, `Start`, or `OnEnable` that then tries to search the scene for the missing dependency
- No service locator
- No global context object that exposes unrelated dependencies
- No static resolver or static singleton access as a substitute for injection

## Required Dependency Sources

If a dependency is required, it must be provided by one of these:

- constructor or method injection through the selected DI container
- explicit serialized reference assigned intentionally
- controlled composition code that passes the dependency directly

If a required dependency is missing, fail fast.

Do not "recover" by searching the scene.

## Fail-Fast Principle

This is required:

```text
Dependency is required
-> dependency must be assigned explicitly
-> missing assignment is a setup error
-> setup error should surface immediately
```

This is forbidden:

```text
Dependency is null
-> search the scene
-> search children
-> search parent
-> silently continue if found
```

## Good Patterns

- installer or lifetime scope registers systems and services explicitly
- views receive only the dependencies they actually use
- serialized references are assigned deliberately in prefabs or scenes
- setup problems are visible early instead of hidden by runtime fallback logic

## Bad Patterns

- `if (_camera == null) _camera = Camera.main;`
- `if (_target == null) _target = FindObjectOfType<Target>();`
- `if (_button == null) _button = GetComponentInChildren<Button>();`
- `GameContext`, `ServiceLocator`, or similar god objects
- public fields exposed "just in case"

## AI Review Guidance

When reviewing dependency wiring, check:

- Is the project using exactly one DI container consistently?
- Are required dependencies explicit?
- Is any scene or hierarchy lookup being used to patch setup mistakes?
- Would a missing dependency fail fast instead of silently recovering?
