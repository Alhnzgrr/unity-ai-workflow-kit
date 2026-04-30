# Object Pooling Skill

## Purpose

Help AI assistants apply object pooling correctly in Unity projects that use rule-driven environments, debug visualization, replay tooling, and repeated runtime markers.

## Core Idea

Do not repeatedly `Instantiate` and `Destroy` short-lived scene objects during active simulation if the same object type can be reused safely.

Pooling is especially useful when Unity is acting as a host and visualization layer for an environment that emits many repeated visual artifacts.

## When To Use Pooling

Use pooling when:

- objects are spawned and removed repeatedly
- runtime debug markers appear often
- legal move indicators are refreshed frequently
- replay visualizers create many temporary objects
- trace visualization creates repeated short-lived UI or world objects
- mobile performance or GC spikes matter

Do not use pooling when:

- objects are spawned once or very rarely
- teardown cost makes safe reuse difficult
- the object lifecycle is too complex to reset reliably
- the added complexity is not justified by the usage frequency

## Typical Environment Use Cases

Good pooling candidates in this project:

- action target highlights
- grid or board indicators
- step result popups
- replay path markers
- debug arrows and gizmo-like runtime helpers
- transient VFX tied to validation or transition feedback

## Core Pattern

```csharp
public sealed class ObjectPool<T> where T : MonoBehaviour
{
    private readonly Queue<T> _pool = new();
    private readonly T _prefab;
    private readonly Transform _parent;

    public ObjectPool(T prefab, int initialSize, Transform parent = null)
    {
        _prefab = prefab;
        _parent = parent;

        for (int index = 0; index < initialSize; index++)
        {
            ReturnToPool(CreateNew());
        }
    }

    public T Get()
    {
        T instance = _pool.Count > 0 ? _pool.Dequeue() : CreateNew();
        instance.gameObject.SetActive(true);
        return instance;
    }

    public void ReturnToPool(T instance)
    {
        instance.gameObject.SetActive(false);
        _pool.Enqueue(instance);
    }

    private T CreateNew()
    {
        return Object.Instantiate(_prefab, _parent);
    }
}
```

## Unity Built-In Pool

Unity provides `ObjectPool<T>` in `UnityEngine.Pool`.

Prefer the built-in pool unless the project needs custom lifecycle or bookkeeping behavior.

```csharp
using UnityEngine.Pool;

private IObjectPool<DebugMarkerView> _markerPool;

private void Awake()
{
    _markerPool = new ObjectPool<DebugMarkerView>(
        createFunc: () => Instantiate(_markerPrefab, _markerRoot),
        actionOnGet: marker => marker.gameObject.SetActive(true),
        actionOnRelease: marker => marker.gameObject.SetActive(false),
        actionOnDestroy: marker => Destroy(marker.gameObject),
        defaultCapacity: 32,
        maxSize: 128
    );
}
```

## Environment-Oriented Rules

- Reset runtime state on `Get`.
- Clear previous references, target bindings, labels, and visuals on `ReturnToPool`.
- Never return the same object twice.
- Pre-warm pools during setup or loading, not during active stepping.
- Keep pooled runtime helpers under a clear scene parent for inspection.
- Pool views and markers, not the authoritative environment state itself.

## Lifecycle Pattern

When pooled objects need explicit reset hooks, use a small lifecycle contract:

```csharp
public interface IPoolable
{
    void OnGetFromPool();
    void OnReturnToPool();
}
```

Typical responsibilities:

- `OnGetFromPool`: reset local visuals, cached labels, temporary animation state
- `OnReturnToPool`: stop effects, cancel local timers, clear references, unsubscribe temporary callbacks

## Example Reset Pattern

```csharp
public sealed class DebugMarkerView : MonoBehaviour
{
    [SerializeField] private TMPro.TextMeshPro _label;

    public void OnGetFromPool()
    {
        transform.localScale = Vector3.one;
        _label.text = string.Empty;
    }

    public void OnReturnToPool()
    {
        _label.text = string.Empty;
    }
}
```

## Safety Rules

- Do not pool objects that still have active async work unless cancellation/reset is handled.
- Do not pool objects with active subscriptions unless release cleanup is guaranteed.
- Do not pool objects that still expose stale environment references.
- Do not treat pooled visual objects as source-of-truth state containers.

## Mobile and Runtime Considerations

- Pre-warm pools before heavy interaction starts.
- Set sensible caps to avoid unbounded memory growth.
- Avoid runtime fallback instantiation in hot loops if the pool is exhausted often.
- Profile pooled debug and visualization systems on device if they stay enabled in runtime builds.

## Common Mistakes

- instantiating new markers every step instead of reusing them
- forgetting to clear old labels or target bindings
- pooling stateful objects without reset hooks
- treating pooled views as authoritative simulation state
- making the pool too small and hitting runtime instantiation repeatedly

## AI Review Guidance

When reviewing pooled systems, check:

- Is pooling used for frequently repeated scene objects?
- Is pooled object state fully reset on retrieval?
- Are environment references cleared on release?
- Is there a guaranteed return path for every acquired object?
- Is pooling applied to presentation/helpers rather than core authoritative state?
