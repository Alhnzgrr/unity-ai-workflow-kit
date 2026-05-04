# Learn Command

## Purpose

Extract repeated, project-specific patterns and decide whether they should become learned knowledge.

Use this command to turn recurring implementation or review insights into stable workflow guidance.

## Use When

Use this command when:

- the same mistake appears multiple times
- the same solution pattern keeps being reintroduced
- a project-specific convention has become stable
- a new item may belong in `skills/learned/`

## Inputs

Provide:

- the relevant code, review notes, or recent changes
- the suspected repeated pattern
- any context showing why it is project-specific

## Expected Output

The output should include:

- the extracted pattern
- why it matters
- whether it belongs in `skills/learned/`
- whether an existing skill should be updated instead
- a suggested learned skill name if applicable

## Required Process

1. identify the repeated pattern or repeated pitfall
2. decide whether it is general or project-specific
3. check whether an existing skill already covers it
4. recommend update existing skill versus add learned skill
5. if a learned skill is justified, propose a focused title and scope

## Output Shape

```text
Observed Pattern:

Why It Matters:

Classification:
- general skill update
- learned skill candidate
- not stable enough yet

Recommended Action:
- ...

Suggested Learned Skill Name:
- ...
```

## Rules

- Do not add one-off notes to learned knowledge.
- Do not duplicate general Unity guidance in `skills/learned/`.
- Prefer fewer high-signal learned skills over broad note dumping.

## Related Skills

- `skills/learned/`
- `skills/unity-core/`
- `skills/unity-architecture/`
- `skills/training/`

## Handoff

This command may lead to:

- a new learned skill
- an update to an existing skill
- no action if the pattern is not stable enough
