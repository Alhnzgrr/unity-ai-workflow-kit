# Failure Diagnosis Skill

## Purpose

Help AI assistants analyze why a Unity environment decision, step, or episode failed.

## Core Idea

A failed outcome is only useful if the cause is identified clearly enough to prevent repetition.

Do not stop at "the action failed."

Explain:

- what failed
- why it failed
- which assumption broke
- what should change next time

## Use When

Use this skill when:

- an invalid action occurs
- an episode ends in failure
- the reward is worse than expected
- the agent loops or stalls
- expected and actual outcomes diverge

## Failure Categories

Classify the failure when possible:

- state misread
- invalid action
- wrong prioritization
- bad target selection
- reward misunderstanding
- termination misunderstanding
- incomplete planning
- rule violation

## Diagnosis Process

1. describe the failing state
2. describe the attempted action or decision
3. compare expected vs actual outcome
4. identify the broken assumption
5. identify the governing rule
6. classify the failure
7. recommend a correction

## Output Shape

```text
Failure Summary:

Failing State:
- ...

Attempted Action:
- ...

Expected Outcome:
- ...

Actual Outcome:
- ...

Broken Assumption:
- ...

Relevant Rule:
- ...

Failure Class:
- ...

Recommended Correction:
- ...
```

## Rules

- Be specific. "Bad move" is not a diagnosis.
- Separate agent error from environment ambiguity.
- Prefer one primary root cause over a vague list of possibilities.
- If multiple issues exist, name the main cause first and secondary causes after.

## Common Mistakes

- blaming reward when the real issue was invalid action
- blaming action choice when state was misread
- describing symptoms without naming the rule
- giving a correction that does not address the root cause

## AI Review Guidance

When reviewing failure analysis, check:

- Did the diagnosis identify a real root cause?
- Did it distinguish expectation from outcome?
- Did it name the specific broken assumption?
- Is the recommended correction actionable?
