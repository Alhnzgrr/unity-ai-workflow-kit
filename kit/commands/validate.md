# Validate Command

## Purpose

Check whether a feature, refactor, or milestone is actually complete enough to move forward.

Use this command as a completion gate rather than a design or coding step.

## Use When

Use this command when:

- implementation appears finished
- review feedback has been applied
- a milestone needs a pass or fail decision
- the next phase depends on the current work being stable enough

## Inputs

Provide:

- acceptance criteria or target outcomes
- the implemented result
- review findings if they exist
- any required constraints such as mobile, determinism, or replay support

## Expected Output

The output should include:

- pass, partial, or fail
- what is complete
- what is still missing
- risks that remain open
- whether it is safe to move to the next step

## Required Process

1. restate the target criteria
2. compare the current implementation against those criteria
3. identify missing behaviors or unresolved risks
4. distinguish blockers from non-blockers
5. give a clear readiness verdict

## Output Shape

```text
Validation Target:

Status:
- Pass / Partial / Fail

Confirmed Complete:
- ...

Missing Or Risky:
- ...

Next-Step Readiness:
- ...
```

## Rules

- Do not assume review completion means validation completion.
- Do not give a pass if critical acceptance criteria are still implicit or unverified.
- Prefer explicit gaps over vague caution.

## Related Skills

- `skills/training/termination-check/SKILL.md`
- `skills/training/episode-review/SKILL.md`
- `skills/unity-architecture/simulation-loop/SKILL.md`

## Handoff

This command usually follows:

- `commands/review-code.md`

It may also feed into:

- release readiness discussion
- `commands/learn.md`
