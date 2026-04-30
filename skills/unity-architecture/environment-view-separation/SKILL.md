# Environment View Separation Skill

## Purpose

Help AI assistants keep Unity environment logic separate from visualization, input adapters, and scene-specific presentation code.

## Core Idea

The environment is the rule engine.

The view is how that engine is displayed, inspected, or interacted with inside Unity.

If these are mixed together, the project becomes harder to test, harder to replay, and harder to evolve for agent-driven workflows.

## Separation Goal

Keep these concerns apart:

### Environment

Owns:

- current state
- legal actions
- transition rules
- reward logic
- terminal conditions
- reset behavior

### View

Owns:

- rendering state in scene or UI
- debug overlays
- animation or highlighting
- input forwarding
- inspector references

The view may observe and forward.

The view should not decide the rules.

## Good Pattern

```text
EnvironmentRunner
  Owns episode state and step logic.

ActionValidationSystem
  Decides whether the action is legal.

EnvironmentDebugView
  Reads current state and displays reward, terminal reason, and legal actions.

AgentInputView
  Converts keyboard, test harness, or command stream input into environment actions.
```

## Bad Pattern

```text
EnvironmentView
  Reads player input
  Decides if action is legal
  Mutates state
  Computes reward
  Ends the episode
  Updates UI
```

## View Responsibilities

Views may:

- display current state
- request an action
- call an environment-facing method
- visualize legal or illegal choices
- show traces and metrics

Views should not:

- own authoritative state transitions
- compute reward
- decide if the episode is done
- define action legality

## Environment Responsibilities

Environment systems should:

- expose state in a readable form
- accept actions through a clear API
- validate actions before applying them
- return deterministic results when possible
- remain usable without the visual scene

## Input Guidance

Input belongs to the view layer or an adapter layer.

This is true even when the "player" is an AI agent.

Examples:

- keyboard input -> input adapter -> environment action
- replay file -> replay adapter -> environment action
- test harness -> test adapter -> environment action

The environment should not care which source produced the action.

## ScriptableObject Guidance

Use ScriptableObjects for:

- environment configuration
- scenario presets
- authorable setup data

Do not use ScriptableObjects as mutable episode state containers unless there is a very specific reason.

## Review Questions

When checking separation, ask:

- Can the environment run without the scene?
- Can the view be replaced without rewriting rule logic?
- Can a replay or test harness drive the same environment?
- Is state mutation happening outside the environment layer?

## Common Mistakes

- putting rule checks inside MonoBehaviour click handlers
- computing reward in UI code
- letting a view mutate core state directly
- mixing debug visualization with authoritative simulation
- coupling the environment to one specific input source

## AI Review Guidance

When reviewing environment-view separation, check:

- Are environment rules owned outside MonoBehaviours?
- Are views acting as adapters instead of controllers?
- Is the environment still testable without rendering?
- Could agent, replay, and human input all hit the same environment API?
