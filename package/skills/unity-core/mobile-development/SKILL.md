# Mobile Development Skill

## Purpose

Help AI assistants build Unity environments and supporting views that run reliably on iOS and Android devices, especially when simulation, debug visualization, and agent-driven interaction coexist.

## Core Idea

Mobile is a constrained runtime.

In this project, mobile concerns are not only about gameplay polish. They also affect:

- environment responsiveness
- debug UI cost
- replay visualization overhead
- trace rendering overhead
- battery and thermal behavior

Every Unity-side feature should be evaluated for mobile impact.

## Mobile Priorities

Aim for:

- stable frame pacing on mid-range devices
- no avoidable GC spikes during active interaction
- lightweight debug and visualization layers
- responsive touch interaction
- predictable battery impact during long sessions

## Environment-Specific Mobile Risks

Watch for:

- expensive per-step debug rendering
- too many temporary markers or overlays
- trace visualization generating repeated allocations
- simulation and visualization being too tightly coupled
- diagnostic UI rebuilding every frame

## CPU Rules

- Keep simulation logic out of heavy MonoBehaviour update chains where possible.
- Avoid unnecessary work every frame when the environment state has not changed.
- Cache references in `Awake` or initialization.
- Avoid LINQ and repeated string work at runtime.
- Throttle optional debug refresh when real-time updates are not necessary.
- Prefer event-driven UI refresh over per-frame polling.

```csharp
// Bad
private void Update()
{
    _debugText.text = BuildLargeStateSummary();
}

// Better
public void RefreshDebugView(EnvironmentSnapshot snapshot)
{
    _debugText.text = BuildStateSummary(snapshot);
}
```

## Memory Rules

- Avoid allocating new visual helpers repeatedly during stepping.
- Pool repeated runtime markers and overlays.
- Keep replay and trace visualizations bounded.
- Avoid loading large optional debug assets on startup if not needed on mobile.
- Be careful with verbose in-memory trace retention during long sessions.

## Rendering Rules

- Keep runtime debug visuals lightweight.
- Avoid excessive overlay stacking and transparent UI overdraw.
- Use shared materials and atlased assets where repeated indicators exist.
- Disable or simplify non-essential visual diagnostics on mobile builds if needed.
- Split static and dynamic UI canvases.

## UI Rules

- Separate always-visible HUD from dynamic trace/debug panels.
- Avoid rebuilding layout-heavy panels every frame.
- Prefer concise debug summaries over large scrolling live logs in the main view.
- Disable `Raycast Target` on decorative UI.
- Use TextMeshPro for readable mobile text.

## Battery and Thermal Rules

Always consider:

- long-running sessions
- repeated visualization updates
- high-frequency redraw of debug panels
- background processing that continues while the screen is idle

Set sensible startup behavior:

```csharp
Application.targetFrameRate = 60;
Screen.sleepTimeout = SleepTimeout.SystemSetting;
```

If the environment is mostly static between steps, avoid pretending it is a full real-time scene.

## Touch Input Rules

- Touch targets should be comfortably sized.
- Step, reset, and inspect actions should feel immediate.
- If selecting targets on a board/grid, visual confirmation must be clear.
- Drag or tap interactions should not depend on tiny hit areas.
- Human mobile input and AI-driven actions should use the same environment-facing API.

## Debug and Evaluation Guidance

On mobile, debug features must be intentional.

Prefer:

- compact state summaries
- optional expandable debug panels
- pooled debug markers
- togglable replay overlays

Avoid:

- always-on verbose trace panels
- unbounded scrolling logs in scene
- per-frame rebuilding of complex diagnostic UI

## Loading and Initialization

- Pre-warm required pools before active interaction starts.
- Load heavy optional visualization assets lazily when possible.
- Separate environment initialization from optional debug tool initialization.
- Keep the first interactive state fast and predictable.

## Profiling Checklist

Before treating a mobile flow as acceptable, check:

- Are there allocations in active step/render paths?
- Are repeated markers pooled?
- Is debug UI updating only when needed?
- Is frame rate capped?
- Are long sessions causing thermal or battery issues?
- Does the environment remain usable when optional debug layers are disabled?

## Common Mistakes

- treating mobile as a smaller desktop build
- updating debug text and panels every frame
- leaving replay or trace overlays always active
- tying simulation updates to heavy visual refresh
- using too many temporary scene objects during step feedback

## AI Review Guidance

When reviewing mobile-oriented Unity features, check:

- Is simulation separated from presentation enough to scale down visuals on mobile?
- Are repeated visual helpers pooled?
- Is debug rendering bounded and optional?
- Does the mobile UX stay responsive even with environment feedback enabled?
- Can the environment still function if diagnostics are reduced?
