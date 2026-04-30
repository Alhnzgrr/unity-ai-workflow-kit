# Action Validation Skill

## Purpose

Help AI assistants validate candidate actions against Unity environment rules before execution.

## Core Idea

A good-looking action is not enough.

The action must be legal, available in the current state, and consistent with the environment rules.

## Use When

Use this skill when:

- the agent is about to choose an action
- the environment has legal / illegal move boundaries
- invalid actions carry penalties or wasted steps
- actions depend on phase, resources, ownership, or target constraints

## Validation Questions

For every candidate action, check:

1. Is this action currently allowed?
2. Is the action available in the current phase or mode?
3. Are all required preconditions satisfied?
4. Is the target valid?
5. Is the action blocked by resource, cooldown, ownership, or sequencing rules?
6. If invalid, what exact rule rejects it?

## Validation Structure

Use this structure:

```text
Action:

Validation Result:
- valid / invalid

Preconditions:
- ...

Blocking Rules:
- ...

Expected State Change:
- ...
```

## Decision Flow

1. enumerate candidate actions
2. reject invalid actions explicitly
3. explain why each rejected action failed
4. rank remaining valid actions
5. choose among valid actions only

## Invalid Action Handling

When an action is invalid, always report:

- attempted action
- failed precondition
- violated rule
- whether state should remain unchanged
- penalty or wasted-step consequence if applicable

## Rules

- Never execute or recommend an action before validation.
- Never mark an action valid without naming the supporting conditions.
- Never hide invalid options if they were seriously considered.
- If legality depends on unknown state, say the validation is incomplete.

## Common Mistakes

- assuming affordance without checking resources
- validating the action type but not the target
- forgetting phase-specific restrictions
- choosing a strong action that is not currently legal

## AI Review Guidance

When reviewing action validation, check:

- Were preconditions evaluated explicitly?
- Were invalid actions rejected for concrete reasons?
- Did the agent confuse "good" with "legal"?
- Did it validate both the action and its target?
