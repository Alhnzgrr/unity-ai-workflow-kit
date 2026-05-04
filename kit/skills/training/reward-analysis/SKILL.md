# Reward Analysis Skill

## Purpose

Help AI assistants interpret reward correctly inside a Unity rule-driven environment.

## Core Idea

Reward is a signal, not a shortcut to truth.

Do not assume that a locally positive reward means the decision was globally correct.

The agent should understand:

- where reward comes from
- what increased it
- what reduced it
- whether the reward aligns with the actual objective

## Use When

Use this skill when:

- a step produces reward or penalty
- the agent is comparing candidate actions
- reward and success are not identical
- the environment contains delayed reward
- reward hacking is a possible risk

## Reward Reading Structure

Separate reward into:

### Immediate Reward

The reward gained or lost from the current step only.

### Cumulative Reward

The total reward accumulated so far in the episode.

### Reward Drivers

The rules or conditions that produced the reward change.

Examples:

- valid completion bonus
- invalid action penalty
- progress bonus
- time cost
- resource waste penalty

### Objective Alignment

Check whether the reward movement actually supports the episode objective.

## Required Process

When analyzing reward:

1. identify the reward change
2. identify the rule or event that caused it
3. separate immediate value from long-term value
4. check whether the reward aligns with the objective
5. call out any misleading or exploitable reward pattern

## Output Shape

```text
Immediate Reward:

Cumulative Reward:

Reward Drivers:
- ...

Objective Alignment:
- aligned / partially aligned / misaligned

Notes:
- ...
```

## Rules

- Never infer reward without a supporting rule or visible signal.
- Do not confuse progress with reward unless the environment defines them as the same.
- Do not treat reward gain as proof of legality.
- If the reward model is unclear, say so explicitly.

## Common Mistakes

- chasing immediate reward while damaging long-term success
- ignoring penalties hidden in future transitions
- assuming a high reward means the episode is solved
- missing reward-hacking opportunities or traps

## AI Review Guidance

When reviewing reward analysis, check:

- Did the agent explain why reward changed?
- Did it separate short-term reward from strategic value?
- Did it test reward against the real objective?
- Did it notice exploit-like behavior?
