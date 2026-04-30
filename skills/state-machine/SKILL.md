# State Machine Skill

## Purpose

Help AI assistants implement state machines in Unity cleanly
without overcomplicating simple behaviors or understructuring complex ones.

## Core Idea

State machines make behavior explicit.
Instead of scattered booleans and nested if-else chains,
each state owns its own logic and transitions.

## When To Use a State Machine

Use when:

* An object has clearly distinct behavioral states (Idle, Running, Jumping, Dead)
* Transitions between states have specific conditions
* State-specific logic is growing inside Update or coroutines
* Adding a new state would require editing many unrelated conditions

Do not use when:

* The object has only two states and the logic is trivial
* A simple boolean or enum check is readable and sufficient
* The added structure would cost more than it saves

## Simple Enum State Machine

For small features with few states:

```csharp
public enum PlayerState { Idle, Running, Jumping, Dead }

public class PlayerController : MonoBehaviour
{
    private PlayerState \_state = PlayerState.Idle;

    void Update()
    {
        switch (\_state)
        {
            case PlayerState.Idle:    HandleIdle();    break;
            case PlayerState.Running: HandleRunning(); break;
            case PlayerState.Jumping: HandleJumping(); break;
            case PlayerState.Dead:    HandleDead();    break;
        }
    }

    private void TransitionTo(PlayerState newState)
    {
        \_state = newState;
    }
}
```

Use this when states are simple and transitions are few.

## Class-Based State Machine

For complex behaviors with enter/exit logic:

```csharp
// Base state
public abstract class BaseState
{
    public abstract void Enter();
    public abstract void Tick(float deltaTime);
    public abstract void Exit();
}

// State machine
public class StateMachine
{
    private BaseState \_currentState;

    public void ChangeState(BaseState newState)
    {
        \_currentState?.Exit();
        \_currentState = newState;
        \_currentState.Enter();
    }

    public void Tick(float deltaTime)
    {
        \_currentState?.Tick(deltaTime);
    }
}

// Example state
public class IdleState : BaseState
{
    private readonly PlayerView \_view;

    public IdleState(PlayerView view)
    {
        \_view = view;
    }

    public override void Enter() => \_view.PlayIdleAnimation();
    public override void Tick(float deltaTime) { }
    public override void Exit() { }
}
```

## Rules

* Each state owns only its own logic
* Transitions happen through the state machine, not inside states
* States should not directly reference each other
* Enter and Exit should handle setup and cleanup
* Keep Tick methods focused — delegate heavy logic to systems

## Transition Clarity

Define transitions explicitly, not scattered across Update:

```csharp
// Clear transition ownership
void Update()
{
    \_stateMachine.Tick(Time.deltaTime);
    HandleTransitions();
}

void HandleTransitions()
{
    if (\_state == PlayerState.Running \&\& !IsGrounded())
        TransitionTo(PlayerState.Jumping);

    if (\_state == PlayerState.Jumping \&\& IsGrounded())
        TransitionTo(PlayerState.Running);
}
```

## Choosing Between Simple and Class-Based

|Situation|Approach|
|-|-|
|2-3 states, minimal enter/exit logic|Enum state machine|
|4+ states with enter/exit behavior|Class-based state machine|
|States need dependency injection|Class-based with constructor injection|
|Rapid prototype, shape not clear yet|Enum first, refactor later|

## Mobile Considerations

* Avoid allocating new state objects on every transition — reuse instances
* Cache state instances at initialization
* Keep Tick methods allocation-free

```csharp
// Pre-instantiate states, do not new them on transition
private IdleState \_idleState;
private RunningState \_runningState;

void Awake()
{
    \_idleState = new IdleState(this);
    \_runningState = new RunningState(this);
}
```

## Common Mistakes

* Putting transition logic inside state classes (creates hidden coupling)
* Using a state machine for a two-state toggle
* Allocating new state objects every transition
* Letting states access each other directly
* Forgetting to call Exit on the previous state

## AI Review Guidance

When reviewing state machine implementations, check:

* Is each state responsible for only its own behavior?
* Are transitions defined in one clear place?
* Are state instances reused or allocated per transition?
* Is Enter and Exit used correctly for setup and cleanup?
* Could a simpler enum approach have been used instead?

