# Catch Up Command

## Purpose

Summarize current project or task state so work can resume without re-reading everything manually.

Use this command when returning to a task, handing work to another agent role, or reconstructing the current workflow state.

## Use When

Use this command when:

- a feature is already in progress
- runtime artifacts or handoffs exist
- the current state is unclear
- a new session needs a concise continuation brief

## Inputs

Provide:

- the task or feature name if known
- relevant folders or files if the scope should be narrowed

## Expected Output

The output should include:

- what has already been done
- what artifacts exist
- what is missing
- current blockers or open risks
- the most logical next agent or command

## Output Shape

```text
Task State Summary:

Completed:
- ...

Artifacts Found:
- ...

Open Issues:
- ...

Recommended Next Step:
- ...
```

## Related Files

- `runtime/tasks/`
- `runtime/handoffs/`
- `runtime/reviews/`
- `runtime/validations/`
- `AGENTS.md`
