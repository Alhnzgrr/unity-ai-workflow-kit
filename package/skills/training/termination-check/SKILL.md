# Termination Check Skill

## Purpose

Help AI assistants determine whether a Unity environment episode should continue or stop.

## Core Idea

Do not declare success, failure, or completion by intuition.

Termination must come from explicit environment conditions.

The agent should know:

- whether the current state is terminal
- why it is terminal
- whether the result is success, failure, or truncation

## Use When

Use this skill when:

- a step may end the episode
- the environment has win / lose conditions
- the run may be horizon-limited
- reward suggests completion but termination is not confirmed

## Termination Classes

### Success

The environment reached a goal state defined by explicit rules.

### Failure

The environment reached a losing or invalid terminal state.

### Truncation

The run stopped because of an outside limit, such as max steps or time horizon.

## Required Process

When checking termination:

1. inspect the current state
2. compare it against explicit terminal conditions
3. determine if the episode is still active
4. if terminal, classify the result
5. state the exact reason

## Output Shape

```text
Terminal Status:
- active / success / failure / truncated

Terminal Reason:
- ...

Supporting Conditions:
- ...
```

## Rules

- Never mark terminal without naming the supporting condition.
- Never mark success only because reward increased.
- Never mark failure only because one step was bad unless the environment says the episode ends there.
- Distinguish environment failure from external truncation.

## Common Mistakes

- declaring victory too early
- confusing a setback with terminal failure
- missing horizon-based truncation
- failing to explain why the episode stopped

## AI Review Guidance

When reviewing termination checks, check:

- Did the agent use explicit terminal conditions?
- Did it distinguish success, failure, and truncation?
- Did it give a concrete terminal reason?
- Did it avoid inferring termination from reward alone?
