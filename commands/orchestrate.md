# Orchestrate Command

## Purpose

Coordinate a feature or task across multiple agents in a defined sequence instead of relying on one free-form response.

Use this command when the work is large enough to benefit from explicit handoffs, review gates, and role changes.

## Use When

Use this command when:

- a feature affects multiple systems or layers
- scene setup, testing, and review all matter
- you want a repeatable workflow instead of ad hoc prompting
- the task should leave artifacts behind for later sessions

## Inputs

Provide:

- the task or feature description
- relevant constraints
- acceptance criteria if available
- current project context if the task is a continuation

## Agent Flow

Default sequence:

1. Unity Architect
2. Gameplay Programmer
3. Unity Setup
4. Tester
5. Code Reviewer
6. Performance Reviewer when needed
7. Game Feel Reviewer when needed
8. Validate

## Required Process

1. classify the task scope and risk
2. decide which agents are required
3. create a phase-by-phase execution plan
4. identify which handoff template each phase should produce
5. define review and validation gates
6. state the first phase clearly before execution

## Output Shape

```text
Task Summary:

Execution Plan:
1. Phase name - Agent - Output
2. Phase name - Agent - Output

Required Handoffs:
- ...

Required Gates:
- ...

First Phase:
- ...
```

## Gate Rules

- Do not skip architecture for high-risk structural work.
- Do not skip Unity Setup if the feature depends on scene, prefab, or asset wiring.
- Do not skip Tester or Code Reviewer for non-trivial features.
- If review returns must-fix issues, route back to implementation before validation.

## Artifacts

When applicable, write or recommend artifacts under:

- `runtime/tasks/`
- `runtime/handoffs/`
- `runtime/reviews/`
- `runtime/validations/`
- `runtime/logs/`

## Related Files

- `AGENTS.md`
- `rules/workflow-orchestration.md`
- `templates/architecture-handoff.md`
- `templates/implementation-handoff.md`
- `templates/setup-handoff.md`
- `templates/test-handoff.md`
- `templates/review-handoff.md`
- `templates/validation-report.md`
