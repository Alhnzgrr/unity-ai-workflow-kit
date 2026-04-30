# Object Pooling Skill

## Purpose
Help AI assistants implement object pooling correctly in Unity
to avoid runtime allocations and garbage collection spikes on mobile.

## Core Idea
Never Instantiate or Destroy frequently spawned objects at runtime.
Create them once, reuse them, return them when done.

## When To Use Pooling
Use pooling when:
- Objects are spawned and destroyed repeatedly (bullets, particles, enemies, coins)
- The feature runs on mobile and allocation spikes are a risk
- Profiler shows GC alloc in a hot path

Do not use pooling when:
- Objects are spawned once or very rarely
- The object has complex teardown that makes reuse impractical
- The added complexity is not justified by the feature size

## Core Pattern

```csharp
public class ObjectPool<T> where T : MonoBehaviour
{
    private readonly Queue<T> _pool = new Queue<T>();
    private readonly T _prefab;
    private readonly Transform _parent;

    public ObjectPool(T prefab, int initialSize, Transform parent = null)
    {
        _prefab = prefab;
        _parent = parent;
        for (int i = 0; i < initialSize; i++)
            ReturnToPool(CreateNew());
    }

    public T Get()
    {
        var obj = _pool.Count > 0 ? _pool.Dequeue() : CreateNew();
        obj.gameObject.SetActive(true);
        return obj;
    }

    public void ReturnToPool(T obj)
    {
        obj.gameObject.SetActive(false);
        _pool.Enqueue(obj);
    }

    private T CreateNew() =>
        Object.Instantiate(_prefab, _parent);
}
```

## Unity Built-in Pool (Unity 2021+)
Unity provides ObjectPool<T> in UnityEngine.Pool.
Prefer this over custom implementations unless you need specific behavior.

```csharp
using UnityEngine.Pool;

private IObjectPool<Bullet> _bulletPool;

void Awake()
{
    _bulletPool = new ObjectPool<Bullet>(
        createFunc: () => Instantiate(bulletPrefab),
        actionOnGet: b => b.gameObject.SetActive(true),
        actionOnRelease: b => b.gameObject.SetActive(false),
        actionOnDestroy: b => Destroy(b.gameObject),
        defaultCapacity: 20,
        maxSize: 100
    );
}
```

## Rules

- Reset runtime state on Get
- Clean up subscriptions, timers, particles, and ownership on ReturnToPool
- Never return the same object twice
- Disable, do not destroy, when returning
- Pre-warm pools at scene load, not during gameplay
- Keep pool parent transform for scene organization

## Lifecycle Pattern

Use separate lifecycle methods when needed:

```csharp
public interface IPoolable
{
    void OnGetFromPool();
    void OnReturnToPool();
}
```

- `OnGetFromPool`: reset gameplay state
- `OnReturnToPool`: stop particles, cancel timers, unsubscribe events

## Reset Pattern

Objects should reset themselves when retrieved:

```csharp
public class Bullet : MonoBehaviour
{
    public void OnGetFromPool()
    {
        _velocity = Vector3.zero;
        _isActive = true;
        _lifetime = 0f;
    }
}
```

## Safety Rules

- Do not pool objects that still have active async operations unless cancellation is handled
- Do not pool objects with event subscriptions unless they unsubscribe on release
- Do not pool objects with network ownership unless explicitly supported

## Mobile Considerations
- Pre-warm all pools during loading screen
- Set maxSize to avoid unbounded memory growth
- Avoid pools for objects with heavy textures loaded per instance
- Profile with Unity Memory Profiler after implementing

## Common Mistakes
- Instantiating inside Update as fallback when pool is empty
- Forgetting to return objects that go off-screen
- Not resetting state before reuse
- Creating pools too small and hitting Instantiate at runtime anyway

## AI Review Guidance

When reviewing pooled systems, check:
- Is the pool pre-warmed before gameplay starts?
- Is object state fully reset on retrieval?
- Is there a guaranteed return path for every Get call?
- Is pool size appropriate for the expected spawn rate?
