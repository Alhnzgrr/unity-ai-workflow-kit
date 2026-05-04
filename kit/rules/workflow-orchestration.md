# Workflow Orchestration Rules

## Purpose

This rule defines when workflow orchestration is optional, when it is required, and which phases may not be skipped.

This is not a style preference.

It exists to reduce AI drift, skipped phases, and inconsistent feature delivery.

## Task Size Classification

Every task should be classified before execution.

### Small Task

A task is small when most of these are true:

- touches one file or one narrow behavior area
- does not add new architecture
- does not require scene, prefab, or asset setup
- has low regression risk
- can be reviewed directly after implementation

### Medium Task

A task is medium when one or more of these are true:

- touches multiple files in one feature area
- introduces a new feature but not a large subsystem
- needs explicit setup notes or test planning
- affects rules, input, serialization, or authored config

### Large Task

A task is large when one or more of these are true:

- introduces or changes architecture boundaries
- affects multiple layers such as Core, Environment, Views, or Data
- requires scene, prefab, or ScriptableObject setup
- has significant regression or production risk
- should leave behind reusable artifacts for later sessions

## Required Workflow By Task Size

### Small Task

Minimum required flow:

1. Gameplay Programmer
2. Code Reviewer

Tester is recommended when the bug or behavior has meaningful edge cases.

### Medium Task

Minimum required flow:

1. Unity Architect or architect-style planning
2. Gameplay Programmer
3. Tester
4. Code Reviewer
5. Validate

Unity Setup is required if the task affects scene, prefab, asset, or installer wiring.

### Large Task

Required flow:

1. Unity Architect
2. Gameplay Programmer
3. Unity Setup when Unity-facing setup is involved
4. Tester
5. Code Reviewer
6. Performance Reviewer when mobile or hot-path impact exists
7. Game Feel Reviewer when interaction quality is a meaningful part of completion
8. Validate

Large tasks should use `commands/orchestrate.md` or `commands/build-feature.md`.

## Handoff Requirements

### Small Task

Handoff artifacts are optional unless the task spans multiple sessions.

### Medium Task

At least one explicit artifact should exist:

- architecture handoff
- implementation handoff
- test handoff
- review handoff

### Large Task

The following artifacts are expected unless clearly not applicable:

- `templates/architecture-handoff.md`
- `templates/implementation-handoff.md`
- `templates/setup-handoff.md`
- `templates/test-handoff.md`
- `templates/review-handoff.md`
- `templates/validation-report.md`

## Gate Rules

### Review Gate

If Code Reviewer returns must-fix issues:

- the task is not complete
- validation may not pass
- the workflow routes back to implementation

### Validation Gate

If validation returns partial or fail:

- the task is not complete
- the workflow may not be closed as done

### Setup Gate

If a feature depends on scene, prefab, asset, or installer wiring:

- Unity Setup may not be skipped
- setup ambiguity is treated as incomplete work

### Test Gate

If a feature changes public behavior, rules, transitions, serialization-sensitive code, or meaningful integration boundaries:

- Tester may not be skipped

## Runtime Artifact Rules

For medium and large tasks, use runtime artifacts when the work spans multiple phases or sessions.

Recommended locations:

- `runtime/tasks/`
- `runtime/handoffs/`
- `runtime/reviews/`
- `runtime/validations/`
- `runtime/logs/`

The purpose is traceability, not bureaucracy.

## Prohibited Workflow Shortcuts

- Do not jump directly from idea to code on large tasks.
- Do not mark a reviewed task complete if must-fix issues remain.
- Do not skip Unity Setup when authoring work is required.
- Do not skip testing discussion for medium or large features.
- Do not claim a feature is done if validation has not passed.

## AI Review Guidance

When reviewing workflow quality, check:

- Was the task sized correctly?
- Were the required agents used?
- Were mandatory gates respected?
- Were artifacts produced when the task warranted them?
- Was the task closed prematurely?
