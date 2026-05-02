# Unity Runtime Rules

## Editor vs Runtime

- `UnityEditor` code must stay in `Editor/` or be guarded explicitly
- runtime assemblies and runtime scripts must not depend on editor-only APIs accidentally

## Required References

If a MonoBehaviour requires references, those references must be assigned intentionally.

Acceptable sources:

- serialized inspector assignment
- prefab assignment
- DI injection
- explicit setup call from composition code

## Forbidden Fallback Patterns

The following are forbidden for required dependencies:

- searching the scene in `Awake`
- searching the scene in `Start`
- searching the hierarchy in `OnEnable`
- auto-repairing missing setup with `Find*` or `GetComponentInChildren`

Examples of forbidden code:

```csharp
private void Awake()
{
    if (_camera == null)
    {
        _camera = Camera.main;
    }
}
```

```csharp
private void Start()
{
    if (_panel == null)
    {
        _panel = GetComponentInChildren<PanelView>(true);
    }
}
```

## Input Boundary

- input code belongs in input views or adapters
- input code forwards actions to systems or environment logic
- input code does not contain rule logic

## Lifecycle Discipline

- `Awake` is for internal initialization and cached setup that is guaranteed locally
- `OnEnable` and `OnDisable` own enable/disable subscriptions
- `Start` should not be used as a hidden dependency recovery phase
- `OnDestroy` and `OnDisable` should clean up owned subscriptions and resources

## Require Explicitness

If a setup is invalid, surface it clearly.

Do not hide invalid setup with scene search logic.

Broken setup should be fixed at authoring time, not masked at runtime.

## Good Patterns

- `[SerializeField] private` for intentional references
- installer-driven or scope-driven dependency wiring
- small MonoBehaviours that render and forward interactions
- local caching of components that are guaranteed to exist on the same object when justified by `[RequireComponent]`

## Bad Patterns

- manager scripts that find half the scene during startup
- `Camera.main` used as setup recovery
- child search used because prefab wiring was skipped
- runtime "self-healing" that hides authoring mistakes

## AI Review Guidance

When reviewing runtime scripts, check:

- Are required references explicit?
- Is `Awake` or `Start` being abused as a scene search phase?
- Is input separated from rule logic?
- Are editor APIs kept out of runtime code?
