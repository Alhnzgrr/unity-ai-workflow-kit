# Scriptable Objects Skill

## Purpose

Help AI assistants use ScriptableObjects correctly in Unity projects that contain rule-driven environments, scenarios, configuration assets, and debug-friendly authoring workflows.

## Core Idea

ScriptableObjects are best used for authorable, reusable, mostly static data.

They are not the default place for mutable episode state.

In this project, ScriptableObjects are especially useful for:

- environment configuration
- scenario presets
- action metadata
- reward tuning values
- seed presets
- debug visualization settings

## Good Uses

Use ScriptableObjects for:

- values designers or developers need to tune in the Inspector
- reusable environment setup definitions
- scenario and ruleset presets
- content that should be shared across scenes or sessions
- static mappings and labels used by views or adapters

## Bad Uses

Do not use ScriptableObjects as:

- the authoritative mutable state of a running episode
- a hidden global runtime singleton
- a substitute for explicit composition
- a container for per-step temporary values

## Recommended Pattern

Keep a clear split:

- ScriptableObjects hold authorable config
- runtime classes hold mutable environment state

```csharp
[CreateAssetMenu(menuName = "Environment/Scenario Config")]
public sealed class ScenarioConfig : ScriptableObject
{
    [SerializeField] private string _scenarioId;
    [SerializeField] private int _boardWidth;
    [SerializeField] private int _boardHeight;
    [SerializeField] private int _maxStepCount;

    public string ScenarioId => _scenarioId;
    public int BoardWidth => _boardWidth;
    public int BoardHeight => _boardHeight;
    public int MaxStepCount => _maxStepCount;
}
```

```csharp
public sealed class EnvironmentState
{
    public int CurrentStep { get; private set; }
    public bool IsTerminal { get; private set; }
}
```

## Environment-Oriented Use Cases

Good ScriptableObject candidates in this project:

- scenario definitions
- board generation presets
- initial resource settings
- reward configuration
- termination threshold config
- input mapping presets
- debug display settings

## Runtime State Rule

Authorable data may come from ScriptableObjects.

Once an episode starts, mutable runtime state should live in plain C# classes or dedicated runtime systems unless there is a very strong reason otherwise.

This keeps:

- tests cleaner
- replay behavior clearer
- reset behavior more explicit
- state ownership easier to reason about

## Loading and Wiring Guidance

ScriptableObjects should be passed into systems explicitly through:

- bootstrap code
- serialized references
- composition setup

Avoid making systems search for assets at runtime without a clear reason.

## Naming and Structure Guidance

- Prefer one clear responsibility per ScriptableObject type.
- Keep fields focused and readable.
- Avoid giant "all settings" assets.
- Group related assets by role: scenario, reward, debug, presentation, input, etc.

## Common Patterns

### Scenario Definition

Defines initial conditions for an episode.

### Reward Config

Defines tuning values used by reward logic.

### Debug View Config

Defines colors, labels, marker sizes, and optional overlays.

## Common Mistakes

- storing live episode state in a shared asset
- mutating asset data during play and treating it as runtime state
- using one mega-asset for unrelated concerns
- hiding dependencies by reading assets from arbitrary global locations
- letting core logic depend on editor-only authoring assumptions

## AI Review Guidance

When reviewing ScriptableObject usage, check:

- Is the asset holding config rather than mutable runtime state?
- Is the asset responsibility narrow and clear?
- Are runtime systems receiving asset data explicitly?
- Would a plain C# runtime class be a better fit for mutable values?
