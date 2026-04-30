# Game Feel Skill

## Purpose

Help AI assistants think beyond working mechanics and improve how gameplay feels.

A feature is not complete just because it functions.

## Game Feel Checklist

Consider:

- input responsiveness
- animation timing
- anticipation
- impact
- camera feedback
- sound effects
- haptics
- particles
- UI feedback
- readability
- pacing
- satisfying completion feedback

## Core Principle

Every important player action should produce clear feedback.

Player action:

```text
Input → Response → Feedback → Result
```

If feedback is missing, the mechanic may feel unfinished even if the logic is correct.

## Mobile Considerations

For mobile games:

- touch response should be immediate
- drag should feel stable and predictable
- release actions should have clear confirmation
- haptics should be used carefully
- UI buttons need readable states
- feedback must be visible on small screens

## Hybrid Casual Considerations

For hybrid casual games:

- the core action should be understandable in seconds
- success should feel satisfying
- failure should feel fair
- upgrades and progression should be readable
- repetition should be softened with variation and reward

## Examples

### Weak Feature

A ball reaches a target and instantly disappears.

### Better Feature

A ball reaches a target, slows slightly, snaps into place, plays a pop sound, emits a small particle burst, increments score with a punch animation, and gives light haptic feedback.

## AI Review Guidance

When reviewing a feature, always ask:

- Does the player clearly understand what happened?
- Does the action feel responsive?
- Is success satisfying?
- Is failure readable?
- Is there enough feedback?
- Is there too much feedback?
- Can this be tuned easily?

## Output Format

When suggesting game-feel improvements, use:

```text
Input Feedback:
Impact Feedback:
UI Feedback:
Audio/VFX/Haptics:
Tuning Values:
Risk:
```
