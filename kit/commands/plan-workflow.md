# Plan Workflow Command

## Purpose

Break a technical plan into a practical implementation sequence.

Use this command to turn architecture into small, clear tasks that can be executed without losing the design intent.

## Use When

Use this command when:

- architecture is approved and implementation is about to start
- a large refactor needs a safe execution order
- multiple systems must be changed without creating unnecessary conflicts
- the next step is unclear even though the design is known

## Inputs

Provide:

- the architecture or design output
- the target scope
- any deadlines or platform constraints
- known files, systems, or folders that will be touched

## Expected Output

The output should include:

- ordered task list
- dependencies between tasks
- critical path
- optional parallel work
- review and validation checkpoints
- suggested skills for risky steps

## Required Process

1. identify the smallest useful delivery slices
2. order them by dependency
3. separate blocking work from optional work
4. mark tasks that affect architecture boundaries, serialization, or input flow
5. insert review and validation points
6. call out the first implementation step clearly

## Output Shape

```text
Workflow Goal:

Ordered Tasks:
1. ...
2. ...
3. ...

Critical Path:
- ...

Parallel Candidates:
- ...

Review Gates:
- ...

Validation Gates:
- ...
```

## Rules

- Prefer concrete tasks over vague phases.
- Keep each task small enough to verify.
- Do not hide risky structural work inside generic steps like "implement system".
- Always identify the first actionable step.

## Related Skills

- `skills/unity-architecture/unity-clean-architecture/SKILL.md`
- `skills/unity-core/serialization-safety/SKILL.md`
- `skills/unity-core/input-system/SKILL.md`

## Handoff

This command should usually feed into:

- implementation work
- `commands/review-code.md`
- `commands/validate.md`
