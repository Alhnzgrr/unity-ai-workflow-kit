# Mobile Development Skill

## Purpose
Help AI assistants make Unity games that run well and feel good
on iOS and Android devices.

## Core Idea
Mobile is a constrained platform.
CPU, GPU, memory, and battery are all limited.
Every technical decision should consider mobile impact.

## Performance Targets
Aim for:
- 60 FPS on mid-range Android devices
- Memory usage under 200MB where possible
- No GC spikes during gameplay
- Load time under 5 seconds for core gameplay

Mid-range Android reference:
- Snapdragon 665 / Mali-G52 class GPU
- 3-4GB RAM
- Do not optimize only for flagship devices

## CPU Rules
- Avoid heavy logic in Update — use event-driven patterns
- Cache component references in Awake or Start
- Avoid LINQ at runtime
- Avoid string operations outside of debug code
- Use object pooling for frequently spawned objects
- Throttle non-critical systems (run every 2-3 frames if acceptable)

```csharp
// Bad
void Update()
{
    var enemies = FindObjectsOfType<Enemy>(); // allocation every frame
}

// Good
private Enemy[] _enemies;
void Awake() => _enemies = FindObjectsOfType<Enemy>();
```

## Memory Rules
- Compress all textures (ASTC for iOS and modern Android)
- Use texture atlases to reduce draw calls
- Unload unused assets explicitly with Resources.UnloadUnusedAssets
- Avoid loading large assets synchronously on the main thread
- Use Addressables for large or optional content

## Rendering Rules
- Keep dynamic draw calls under 100 for mid-range targets
- Enable static batching for non-moving geometry
- Enable dynamic batching for small moving objects
- Avoid overdraw — especially on UI and particles
- Use mobile-friendly shaders (Unlit or Mobile shader variants)
- Disable HDR and post-processing unless essential
- Limit real-time lights — prefer baked lighting

## Physics Rules
- Set Physics timestep to 0.02 or higher (never lower without reason)
- Use layer-based collision matrix to skip unnecessary checks
- Avoid mesh colliders on dynamic objects — use primitives
- Throttle raycasts — do not raycast every frame unless necessary

## UI Rules (uGUI)
- Split Canvas into static and dynamic layers
- Avoid modifying layout groups every frame
- Disable Raycast Target on non-interactive elements
- Use TextMeshPro instead of legacy Text
- Avoid world-space Canvas unless intentional

```csharp
// Disable raycast on decorative images
image.raycastTarget = false;
```

## Battery and Device Rules
Always set in project startup:

```csharp
Application.targetFrameRate = 60;
Screen.sleepTimeout = SleepTimeout.SystemSetting;
```

- Do not run at uncapped frame rate
- Avoid continuous heavy computation when the game is idle
- Release audio resources when the app is backgrounded

## Touch Input Rules
- Touch targets should be at least 48x48 dp
- Drag input should feel immediate — avoid input buffering
- Release actions should have clear visual confirmation
- Support both portrait and landscape if required early — retrofitting is expensive
- Test on real devices — simulator touch behavior differs

## Loading and Initialization
- Show a loading screen before heavy initialization
- Pre-warm object pools during load, not during gameplay
- Use async loading for scenes (LoadSceneAsync)
- Avoid synchronous asset loads after initial load

```csharp
// Async scene load
IEnumerator LoadGameScene()
{
    var op = SceneManager.LoadSceneAsync("Game");
    op.allowSceneActivation = false;

    while (op.progress < 0.9f)
    {
        UpdateLoadingBar(op.progress);
        yield return null;
    }

    op.allowSceneActivation = true;
}
```

## Profiling Checklist
Before shipping a build, profile with:
- Unity Profiler (CPU and memory)
- Unity Memory Profiler (texture and asset memory)
- Frame Debugger (draw call audit)
- Real device testing on a mid-range Android

## Common Mistakes
- Optimizing only on high-end test devices
- Leaving FindObjectsOfType calls in Update
- Uncapped frame rate draining battery
- Uncompressed textures shipped in final build
- Canvas rebuilding every frame due to dynamic content on static canvas
- Forgetting to disable Raycast Target on decorative UI elements

## AI Review Guidance
When reviewing mobile features, check:
- Are there allocations in hot paths?
- Is frame rate capped?
- Are textures compressed?
- Is the Canvas split correctly?
- Are object pools used for frequent spawns?
- Has this been tested on a mid-range device, not just the editor?
