# Architect Command

## Purpose

Produce a technical plan before implementation starts.

Use this command to turn a feature idea into a clear Unity architecture proposal with explicit boundaries.

## Use When

Use this command when:

- a new feature has no technical plan yet
- a new environment or simulation system is being introduced
- existing architecture needs a structural extension
- the implementation risk is high enough that coding first would create churn

## Inputs

Provide:

- the feature or system description
- the intended user, player, or agent behavior
- relevant constraints such as mobile, replay, determinism, or performance
- existing folders, classes, or systems that the new work must fit into

## Expected Output

The output should include:

- class or system list
- responsibilities for each major part
- data flow
- Unity layer versus plain C# layer boundaries
- key risks
- validation notes

## Required Process

1. restate the feature goal in concrete terms
2. identify the authoritative state and main transitions
3. separate Core, Environment, Views, Data, and Composition responsibilities
4. list the main classes or systems
5. identify risky boundaries or likely failure points
6. recommend the skills most relevant for implementation

## Output Shape

```text
Feature Goal:

Architecture Summary:

Main Systems:
- ...

Boundaries:
- ...

Data Flow:
- ...

Risks:
- ...

Recommended Skills:
- ...
```

## Rules

- Do not jump into code unless the request explicitly asks for code.
- Do not collapse all responsibilities into one MonoBehaviour.
- Do not leave environment and view boundaries implicit.
- Prefer simple structure first, but keep production-safe boundaries.

## Related Skills

- `skills/unity-architecture/unity-clean-architecture/SKILL.md`
- `skills/unity-architecture/environment-view-separation/SKILL.md`
- `skills/unity-architecture/simulation-loop/SKILL.md`
- `skills/unity-architecture/state-machine/SKILL.md`

## Handoff

This command should usually feed into:

- `commands/plan-workflow.md`
- implementation with `agents/gameplay-programmer.md`
