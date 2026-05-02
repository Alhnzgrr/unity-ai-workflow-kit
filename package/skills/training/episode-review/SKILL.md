# Episode Review Skill

## Purpose

Help AI assistants evaluate a completed Unity environment episode as a whole, not just step by step.

## Core Idea

A run should not be judged only by whether it ended in success or failure.

The full episode should be reviewed for:

- decision quality
- rule adherence
- efficiency
- reward trajectory
- repeated mistakes

## Use When

Use this skill when:

- an episode has ended
- multiple runs need comparison
- the agent must learn from a completed trajectory
- a benchmark or policy review is needed

## Review Dimensions

### Outcome

Check:

- success / failure / truncation
- terminal reason
- final reward
- step count

### Decision Quality

Check:

- were actions consistently legal
- were important opportunities missed
- were steps wasted
- was the policy stable or erratic

### Rule Adherence

Check:

- invalid action attempts
- rule violations
- assumptions treated as facts
- incorrect terminal claims

### Reward Behavior

Check:

- did the reward trend align with the objective
- were there short-sighted reward grabs
- was there any sign of reward hacking

### Repeated Patterns

Check:

- repeated misreads
- repeated invalid actions
- repeated targeting mistakes
- repeated inefficient loops

## Required Process

1. summarize the episode objective
2. summarize the final outcome
3. identify the strongest decisions
4. identify the most costly mistakes
5. classify any repeated failure pattern
6. recommend the single highest-value improvement

## Output Shape

```text
Episode Objective:

Outcome Summary:
- ...

Strengths:
- ...

Costly Mistakes:
- ...

Repeated Patterns:
- ...

Priority Improvement:
- ...
```

## Rules

- Do not review only the final step.
- Do not confuse success with high-quality policy.
- Do not confuse failure with useless trajectory.
- Always recommend an actionable next improvement.

## Common Mistakes

- focusing only on reward total
- ignoring inefficient but legal action sequences
- ignoring repeated small mistakes
- giving vague feedback like "play better"

## AI Review Guidance

When reviewing an episode review, check:

- Did it evaluate the run beyond simple outcome?
- Did it identify the most expensive mistake clearly?
- Did it separate one-off errors from repeated patterns?
- Is the next improvement concrete and useful?
