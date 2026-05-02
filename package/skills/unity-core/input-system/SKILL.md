# Input System Skill

## Purpose

Help AI assistants use Unity input in a way that stays compatible with rule-driven environments, agent actions, replay input, and mobile interaction.

## Core Idea

Input is not the environment.

Input is only one possible source of actions.

In this project, keyboard, touch, replay, tests, and AI control should all be able to drive the same environment-facing action API.

## Main Rule

Unity input belongs in adapter or view code.

The environment should receive actions, not raw Unity input details.

## Good Separation

```text
Keyboard / Touch / Replay / AI
    ->
Input Adapter
    ->
Environment Action
    ->
Environment Runner
```

This keeps the environment independent from:

- keyboard bindings
- touch gestures
- input polling details
- generated input classes

## Recommended Pattern

Use the Unity Input System to translate platform input into environment actions.

```csharp
public sealed class EnvironmentInputView : MonoBehaviour
{
    [SerializeField] private EnvironmentController _controller;

    private PlayerControls _controls;

    private void Awake()
    {
        _controls = new PlayerControls();
    }

    private void OnEnable()
    {
        _controls.Gameplay.Enable();
        _controls.Gameplay.Submit.performed += OnSubmit;
        _controls.Gameplay.Reset.performed += OnReset;
    }

    private void OnDisable()
    {
        _controls.Gameplay.Submit.performed -= OnSubmit;
        _controls.Gameplay.Reset.performed -= OnReset;
        _controls.Gameplay.Disable();
    }

    private void OnSubmit(InputAction.CallbackContext context)
    {
        _controller.TryRunSelectedAction();
    }

    private void OnReset(InputAction.CallbackContext context)
    {
        _controller.ResetEnvironment();
    }
}
```

## Environment Rule

The environment should expose methods or commands such as:

- `ResetEnvironment()`
- `TrySelectTarget(...)`
- `TrySubmitAction(...)`
- `Step(EnvironmentAction action)`

It should not know whether the action came from:

- touch
- mouse
- keyboard
- replay
- automated agent

## Continuous vs Discrete Input

### Discrete Input

Use callbacks for:

- submit
- cancel
- reset
- confirm
- next replay step

### Continuous Input

Use polling when appropriate for:

- cursor movement
- drag position
- board hover
- analog or directional navigation

But still convert the result into environment-friendly state or actions.

## AI and Replay Compatibility

Human input should not get privileged code paths.

A healthy structure is:

- human input adapter -> environment action
- AI policy output -> environment action
- replay file -> environment action

All three should converge on the same environment API.

## Mobile Guidance

On mobile:

- touch targets must be clear and forgiving
- taps, drags, and releases should map cleanly to environment actions
- visual confirmation should appear quickly
- avoid fragile hit targets for environment-critical interactions

## Input Ownership Rules

- Input adapters own Unity input bindings.
- Views may interpret interaction context for presentation.
- Environment systems own legality and state mutation.
- Input adapters should not decide reward, legality, or terminal state.

## Common Mistakes

- putting rule checks in input callbacks
- having separate logic paths for player and AI actions
- letting input adapters mutate state directly
- coupling the environment to a generated `PlayerControls` class
- forgetting to unsubscribe callbacks in `OnDisable`

## AI Review Guidance

When reviewing input-system usage, check:

- Is Unity input isolated from environment rules?
- Can AI, replay, and human input use the same environment API?
- Are callbacks subscribed and unsubscribed safely?
- Is action legality decided by the environment rather than the input layer?
