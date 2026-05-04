# Build Feature Command

## Purpose

Run a feature through the standard build workflow from design to validation.

Use this command when the user wants one coherent feature flow instead of issuing each phase manually.

## Use When

Use this command when:

- a new feature is being added
- a vertical slice needs to be driven end to end
- the task is large enough to need architecture, setup, testing, and review

## Inputs

Provide:

- feature description
- constraints
- acceptance criteria
- any existing architecture notes

## Default Flow

1. architect the feature
2. plan the workflow if needed
3. implement the code
4. define Unity setup
5. define testing and validation
6. review the result
7. validate readiness

## Expected Output

The output should include:

- phase list
- required agents
- required handoff files
- required validation gates
- next immediate action

## Rules

- Do not pretend all phases are complete if only planning has been done.
- Keep the flow explicit and traceable.
- Call out skipped phases and why they were skipped.

## Related Files

- `commands/orchestrate.md`
- `commands/architect.md`
- `commands/plan-workflow.md`
- `commands/review-code.md`
- `commands/validate.md`
