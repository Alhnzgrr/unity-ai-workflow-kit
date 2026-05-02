# State Machine Skill

## Purpose

Help AI assistants apply state machines in Unity for environment flow, episode lifecycle, and rule-driven simulation without overengineering.

## Core Idea

State machines are useful when the environment has explicit modes or phases and the allowed behavior changes by state.

In this project, the most important uses are usually:

- episode lifecycle
- turn or phase flow
- simulation mode changes
- agent control mode changes

## When To Use a State Machine

Use when:

- the environment has distinct phases with different legal actions
- transitions depend on clear rules
- reset / running / terminal flow must be explicit
- behavior changes by mode rather than by isolated flags

Do not use when:

- one enum check is enough
- the flow has only trivial branching
- state boundaries are not meaningful yet

## Recommended State Machine Uses

### Episode Lifecycle

Example states:

- `Uninitialized`
- `Ready`
- `Running`
- `Succeeded`
- `Failed`
- `Truncated`

### Turn or Phase Flow

Example states:

- `AwaitingAction`
- `ValidatingAction`
- `ApplyingTransition`
- `ComputingReward`
- `CheckingTermination`

### Simulation Mode

Example states:

- `HumanControl`
- `AgentControl`
- `Replay`
- `Paused`

## Simple Enum Approach

Use this when the state flow is small and stable:

```csharp
public enum EpisodeState
{
    Ready,
    Running,
    Succeeded,
    Failed,
    Truncated
}

public sealed class EpisodeFlow
{
    public EpisodeState State { get; private set; } = EpisodeState.Ready;

    public void StartEpisode()
    {
        State = EpisodeState.Running;
    }

    public void MarkSuccess()
    {
        State = EpisodeState.Succeeded;
    }
}
```

## Class-Based State Machine

Use this when states have meaningful enter/exit behavior or distinct validation rules:

```csharp
public interface IEnvironmentState
{
    void Enter();
    void Exit();
    void Tick();
}

public sealed class EnvironmentStateMachine
{
    private IEnvironmentState _currentState;

    public void ChangeState(IEnvironmentState newState)
    {
        _currentState?.Exit();
        _currentState = newState;
        _currentState.Enter();
    }

    public void Tick()
    {
        _currentState?.Tick();
    }
}
```

## Environment-Oriented Rule

Use state machines to control flow, not to hide core rules.

Good:

- a state defines which phase is active
- a state determines which operations are available
- a state coordinates when validation or stepping may occur

Bad:

- reward logic duplicated inside multiple states
- transition rules hidden in scattered state classes
- rule ownership split unclearly between state and system

## Transition Clarity

Transitions should be explicit and reviewable.

Good questions:

- what condition caused the transition
- who owns that condition
- what becomes legal after the transition
- what becomes illegal after the transition

## Recommended Pattern

For environment flow, a good split is:

- state machine owns phase / mode
- validation system checks legal actions
- transition system applies changes
- reward system computes reward
- termination system decides whether the episode ends

The state machine should orchestrate mode changes, not absorb all behavior.

## Choosing Between Simple and Class-Based

| Situation | Approach |
| - | - |
| Small episode lifecycle with 3-5 states | Enum state machine |
| States have enter/exit work or separate policies | Class-based state machine |
| Environment has multiple orthogonal concerns | Prefer small focused state machines |
| Flow is still unclear | Start with enum, refactor later |

## Common Mistakes

- using a state machine for everything
- burying transition rules inside many state classes
- mixing episode state with gameplay/UI state in one machine
- duplicating validation logic across states
- creating large god-state classes

## AI Review Guidance

When reviewing state machine usage, check:

- Does the state machine model a real boundary?
- Are transitions explicit?
- Is rule logic still owned by the right systems?
- Would a simpler enum have been enough?
