# Dependency Injection Skill

## Purpose

Help AI assistants apply dependency injection in Unity projects where environment logic, simulation systems, and debug views need explicit wiring and testability.

## Core Idea

Dependency injection is useful when it makes the runtime graph clearer.

It is not mandatory architecture.

In this project, DI is a tool for wiring:

- environment services
- validation systems
- reward systems
- debug views
- replay or logging adapters

without hiding dependencies behind globals.

## What Problem DI Solves

DI helps when classes should receive dependencies instead of creating or searching for them.

Good outcome:

- explicit dependencies
- easier tests
- easier swaps between real and mock implementations
- cleaner separation between environment logic and Unity adapters

## When To Use DI

Use when:

- multiple environment systems share services
- environment logic should run in tests with mock adapters
- the runtime graph is large enough that manual wiring is noisy
- debug, replay, and evaluation adapters need swapping

Do not use when:

- the environment is still tiny
- manual composition is clearer
- the framework would add more ceremony than value

## Preferred Order

### 1. Manual Composition First

For small and mid-size environments, manual wiring is often enough:

```csharp
public sealed class EnvironmentBootstrap : MonoBehaviour
{
    [SerializeField] private EnvironmentDebugView _debugView;

    private void Awake()
    {
        var validator = new ActionValidationSystem();
        var reward = new RewardSystem();
        var termination = new TerminationSystem();
        var environment = new EnvironmentRunner(validator, reward, termination);

        _debugView.Initialize(environment);
    }
}
```

This keeps the composition root visible.

### 2. DI Framework When the Graph Grows

If the runtime graph becomes large, a DI container can help.

Use it to wire the graph, not to replace architecture.

## Constructor Injection

Prefer constructor injection for plain C# systems:

```csharp
public sealed class EnvironmentRunner
{
    private readonly ActionValidationSystem _validator;
    private readonly RewardSystem _rewardSystem;

    public EnvironmentRunner(ActionValidationSystem validator, RewardSystem rewardSystem)
    {
        _validator = validator;
        _rewardSystem = rewardSystem;
    }
}
```

## MonoBehaviour Injection

MonoBehaviours cannot use constructor injection directly.

Use explicit initialization or framework-supported method injection:

```csharp
public sealed class EnvironmentDebugView : MonoBehaviour
{
    private EnvironmentRunner _environment;

    public void Initialize(EnvironmentRunner environment)
    {
        _environment = environment;
    }
}
```

## Interface Guidance

Use interfaces only where the boundary matters.

Good reasons:

- test doubles
- multiple adapters
- replay vs live input source
- file logger vs in-memory logger

Bad reasons:

- every class "just in case"
- wrappers around trivial one-off systems

## Rules

- Prefer explicit composition roots.
- Prefer constructor injection for plain C# classes.
- Do not inject the container into runtime systems.
- Do not use service locators.
- Do not use DI to hide architecture problems.
- Keep environment systems understandable without knowing the DI framework.

## Unity-Specific Guidance

- Composition belongs in bootstrap/install/wiring code, not scattered through gameplay classes.
- Views and adapters may be initialized from a MonoBehaviour composition root.
- Environment logic should remain testable even if the DI framework is removed.

## AI Review Guidance

When reviewing DI usage, check:

- Are dependencies explicit?
- Is the composition root clear?
- Would manual wiring be simpler here?
- Is the framework solving a real problem or just adding ceremony?
