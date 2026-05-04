# Simulation Loop Skill

## Purpose

Help AI assistants structure Unity rule-driven environments around a clean, explicit simulation loop.

## Core Idea

A rule-driven environment should have a standard loop.

The most important operations are usually:

- reset
- observe
- validate
- step
- reward
- termination

If these are scattered across unrelated classes or MonoBehaviours, the environment becomes difficult to reason about and hard to evaluate consistently.

## Recommended Loop

Use this conceptual order:

1. reset environment
2. produce current observation
3. receive candidate action
4. validate action
5. apply transition
6. compute reward
7. check termination
8. emit result / trace

## Core Responsibilities

### Reset

Starts a new episode from a known state.

Should define:

- starting state
- seed handling
- scenario selection
- counters cleared

### Observe

Produces the state representation consumed by the agent, player, or debugger.

Observation should be readable without mutating state.

### Validate

Checks whether the action is legal in the current state.

Validation should happen before mutation.

### Step

Applies the action to produce the next authoritative state.

### Reward

Computes the immediate reward from the transition.

Reward should not be implicitly buried inside UI or unrelated classes.

### Termination

Determines whether the episode remains active, succeeds, fails, or truncates.

## Example Shape

```csharp
public sealed class StepResult
{
    public bool IsValid { get; init; }
    public float Reward { get; init; }
    public bool IsDone { get; init; }
    public string DoneReason { get; init; }
}

public sealed class EnvironmentRunner
{
    public void Reset(int seed) { }
    public Observation GetObservation() => default;
    public StepResult Step(EnvironmentAction action) => default;
}
```

The exact types can differ, but the loop responsibilities should stay explicit.

## Unity-Specific Guidance

- Keep the loop in plain C# where possible.
- Let MonoBehaviours trigger or visualize loop operations, not own them.
- Views may call `Reset()` or `Step(...)`, but should not embed reward or done logic.
- Debug tools may inspect loop outputs without becoming part of the loop.

## Determinism Guidance

If the environment supports deterministic replay:

- store the seed
- store the action sequence
- store terminal reason

The simulation loop should make replay possible, not block it.

## Good Pattern

```text
EnvironmentBootstrap
  Wires dependencies.

EnvironmentRunner
  Coordinates reset and step flow.

ActionValidationSystem
  Checks legality.

TransitionSystem
  Applies state change.

RewardSystem
  Computes reward.

TerminationSystem
  Checks done state.

EnvironmentDebugView
  Displays outputs from the loop.
```

## Bad Pattern

```text
GameControllerMonoBehaviour
  Resets episode
  Reads input
  Validates actions
  Mutates state
  Computes reward
  Decides terminal status
  Updates debug UI
```

## Common Mistakes

- mutating state before validation
- mixing reward and transition logic in one unclear method
- letting done checks live in multiple places
- not emitting enough information for replay or review
- tying the loop to one input source or scene object

## AI Review Guidance

When reviewing simulation loops, check:

- Is reset explicit?
- Is validation separate from transition?
- Is reward computed in a clear place?
- Is termination checked explicitly?
- Could the same loop support agent control, replay, and test execution?
