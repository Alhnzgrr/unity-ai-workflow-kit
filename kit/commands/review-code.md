# Review Code Command

## Purpose

Review implemented code for correctness, architecture quality, and Unity-specific risks.

Use this command as a quality gate after implementation or refactoring work.

## Use When

Use this command when:

- a feature has been implemented
- a refactor is complete
- architecture-sensitive files changed
- input, serialization, or environment boundaries may have shifted

## Inputs

Provide:

- the changed code or changed files
- the intended behavior
- the architecture or workflow plan if available
- any known constraints such as mobile or determinism

## Expected Output

The output should prioritize:

- must-fix issues
- should-improve issues
- optional improvements
- test gaps
- boundary violations
- performance or lifecycle risks when relevant

## Required Process

1. check whether the code matches the intended behavior
2. check architecture boundaries
3. check Unity lifecycle and serialization risks
4. check clarity of state, transition, and input flow
5. identify missing tests or missing validation coverage
6. separate critical findings from lower-priority improvements

## Output Shape

```text
Must Fix:
- ...

Should Improve:
- ...

Optional:
- ...

Testing Gaps:
- ...
```

## Rules

- Findings come first.
- Prioritize correctness and boundary risks over style preferences.
- Do not hide serious issues inside general summaries.
- If no findings are present, say so explicitly and note any residual risk.

## Related Skills

- `skills/training/state-analysis/SKILL.md`
- `skills/training/action-validation/SKILL.md`
- `skills/unity-core/serialization-safety/SKILL.md`
- `skills/unity-architecture/environment-view-separation/SKILL.md`

## Handoff

This command usually works before:

- `commands/validate.md`
- performance or game-feel review
