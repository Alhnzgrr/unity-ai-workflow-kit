# Unity Clean Architecture Skill

## Purpose

Help AI assistants structure Unity projects for rule-driven environments, simulation loops, and agent evaluation without collapsing logic into MonoBehaviours.

## Core Idea

In this project, Unity is the host runtime and visualization layer.

The environment rules, state transitions, reward logic, and termination logic should live in plain C# wherever possible.

MonoBehaviours should coordinate Unity-specific concerns such as:

- scene references
- rendering
- input adapters
- debug visualization
- editor wiring

## Recommended Layers

```text
Core/
  Pure C# state, actions, observations, rules, rewards, termination checks

Environment/
  Step execution, validation, transition logic, episode flow

Views/
  MonoBehaviours, inspectors, UI, debug overlays, visualization

Data/
  ScriptableObjects, configs, scenario definitions, seedable setup data

Composition/
  Runtime wiring and dependency setup
```

## Role of Each Layer

### Core

Owns the language of the environment:

- state models
- action definitions
- observation definitions
- validation rules
- reward rules
- terminal conditions

Core should be testable without a scene.

### Environment

Owns the simulation loop:

- reset
- validate
- step
- reward
- done

This is where the environment behaves, but it should still avoid unnecessary Unity coupling.

### Views

Own the presentation of environment state:

- render current state
- display traces
- visualize legal targets
- forward human or debug input

Views should not own the rules.

### Data

Holds static or authorable content:

- environment config
- scenario definitions
- balancing data
- seed presets

Runtime mutable state should not live in ScriptableObjects.

### Composition

Creates and wires the runtime graph.

This can be manual or DI-based, but wiring should be explicit.

## Dependency Direction

Prefer:

```text
Views -> Environment -> Core
Data  -> Environment -> Core
Composition -> everything
```

Rules:

- Core should not know about Views.
- Environment should not depend on scene objects unless acting through a narrow adapter.
- Views can read state and call environment-facing APIs, but should not implement rule logic.

## Good Example

```text
AgentInputView
  Reads keyboard, test input, or agent command stream.

ActionValidationSystem
  Checks whether an action is legal in the current state.

StepExecutionSystem
  Applies a valid action and produces the next state.

RewardSystem
  Computes step reward.

TerminationSystem
  Determines whether the episode has ended.

EnvironmentDebugView
  Displays current state, reward, and done reason in Unity.
```

## Bad Example

```text
EnvironmentController
  Reads input
  Decides legal actions
  Applies transitions
  Computes reward
  Tracks done state
  Updates UI
  Spawns debug objects
  Saves replay data
```

## Architectural Rules

- Keep rule logic testable in plain C#.
- Keep MonoBehaviours thin.
- Separate validation from execution.
- Separate reward logic from transition logic.
- Separate termination checks from reward checks.
- Prefer composition over inheritance.
- Use interfaces only at meaningful boundaries.
- Avoid manager classes that own unrelated responsibilities.

## Unity-Specific Guidance

- Use MonoBehaviours as adapters, not as the environment brain.
- Use ScriptableObjects for configs and scenarios, not mutable episode state.
- Keep debug visualization optional and replaceable.
- If an environment can run headless, prefer that design.

## When To Refactor

Refactor when:

- a MonoBehaviour starts owning rule logic
- validation and transition logic are mixed together
- reward and done checks are spread across unrelated classes
- the environment cannot be tested without entering Play Mode
- adding one action requires editing too many unrelated files

## When Not To Refactor

Do not split a tiny environment into many abstractions before the state/action model is clear.

Do not add indirection only to look architectural.

Start with clean boundaries, then deepen them where pressure appears.

## AI Review Guidance

When reviewing architecture, check:

- Is the environment logic separable from the Unity scene?
- Are validation, transition, reward, and termination distinct responsibilities?
- Are MonoBehaviours acting as adapters rather than rule owners?
- Could the main simulation run in tests without rendering?
