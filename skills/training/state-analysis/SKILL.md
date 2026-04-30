# State Analysis Skill

## Purpose

Help AI assistants read Unity environment state correctly before choosing an action.

## Core Idea

Bad action selection usually starts with bad state reading.

Do not move directly from observation to action.

First understand:

- what is confirmed
- what is inferred
- what is missing
- what matters for the next decision

## Use When

Use this skill when:

- the agent must decide what to do next
- the environment exposes multiple state values
- there is partial information or uncertainty
- a failure may come from misreading the situation

## State Reading Structure

Always split state into these groups:

### Confirmed Facts

Values explicitly present in the current state or observation.

Examples:

- current phase
- resource count
- active unit
- turn owner
- legal target list

### Derived Facts

Facts computed from confirmed values.

Examples:

- player cannot afford the action
- current branch is irreversible
- next step may trigger termination

### Unknowns

Information not directly available.

Examples:

- hidden future state
- unresolved random outcome
- unobserved enemy intent

### Decision-Critical Factors

Only the values that materially affect the next action.

Do not summarize irrelevant state just because it exists.

## Required Process

Before selecting an action:

1. summarize the current objective
2. list confirmed facts
3. list derived facts
4. list relevant unknowns
5. identify immediate risks
6. identify immediate opportunities
7. state what information is sufficient for action selection

## Output Shape

Use this structure when reporting state:

```text
Objective:

Confirmed Facts:
- ...

Derived Facts:
- ...

Unknowns:
- ...

Decision-Critical Factors:
- ...

Risks:
- ...

Opportunities:
- ...
```

## Rules

- Do not present an inference as a confirmed fact.
- Do not invent hidden state.
- Do not treat old state as current state without confirmation.
- Prefer concise state summaries that preserve decision quality.

## Common Mistakes

- jumping to action before reading constraints
- mixing assumptions with observations
- summarizing too much irrelevant information
- ignoring unknowns that can flip the decision

## AI Review Guidance

When reviewing state analysis, check:

- Did the agent separate facts from assumptions?
- Did it identify the values that actually constrain action?
- Did it ignore important unknowns?
- Did it prepare enough context for action validation?
