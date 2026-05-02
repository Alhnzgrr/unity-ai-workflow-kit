# Game Feel Skill

## Purpose

Help AI assistants improve how a Unity environment feels to interact with, inspect, and understand, not just whether it functions correctly.

## Core Idea

In this project, "feel" is not only about action juice.

It is also about interaction clarity.

A correct environment can still feel bad if:

- inputs feel delayed
- valid and invalid actions are not clearly distinguished
- step outcomes are hard to read
- replay or debug feedback is confusing
- state changes are technically correct but visually unclear

## Interaction Flow

Every important interaction should feel readable:

```text
Intent -> Response -> Feedback -> Result
```

If any part of that chain is weak, the environment may feel unreliable even when the logic is correct.

## What To Evaluate

Consider:

- input responsiveness
- clarity of selected targets
- visibility of legal vs illegal actions
- step result readability
- reward feedback
- terminal feedback
- replay readability
- debug overlay clarity
- pacing between action and result

## Environment-Oriented Feel Questions

Ask:

- Does the user clearly understand what action was attempted?
- Is it obvious whether the action was valid or invalid?
- Is the resulting state change easy to perceive?
- Is reward feedback visible without being noisy?
- Is terminal success or failure clear?
- Does replay/debug visualization help understanding instead of adding clutter?

## Valid vs Invalid Action Feedback

This is especially important in a rule-driven environment.

Valid actions should feel:

- responsive
- intentional
- acknowledged clearly

Invalid actions should feel:

- clearly rejected
- informative rather than confusing
- visually distinct from valid execution

Good examples:

- highlight allowed targets before commit
- show subtle reject feedback for illegal moves
- use different audio/visual response for valid vs invalid action

## Step Result Clarity

After a step:

- the changed state should be easy to see
- any reward or penalty should be understandable
- the next decision context should become clearer, not noisier

Avoid feedback that hides the actual state transition.

## Replay and Debug Feel

If Unity is used for replay, testing, or environment inspection:

- replay stepping should be easy to follow
- markers and overlays should guide the eye
- debug text should summarize, not overwhelm
- important transitions should stand out

Clarity matters more than spectacle here.

## Mobile Considerations

For mobile:

- touch response should feel immediate
- target selection should be obvious on small screens
- invalid tap feedback should be clear but lightweight
- debug overlays should not overwhelm the play area
- feedback must survive small display size and hand occlusion

## Good Pattern

```text
Tap target
-> selected target highlights
-> submit action
-> valid action gets clear confirmation
-> state change becomes visible
-> reward or failure reason appears clearly
```

## Bad Pattern

```text
Tap target
-> no clear selection
-> action silently rejected or accepted
-> state changes subtly with no emphasis
-> reward/failure status is unclear
```

## Tuning Guidance

Expose tunable values for:

- selection highlight intensity
- invalid action feedback duration
- replay speed
- debug marker lifetime
- result popup duration

Do not hardcode all feedback timing if it will need iteration.

## Common Mistakes

- treating valid and invalid actions too similarly
- giving no feedback for rejected actions
- using noisy debug visuals that obscure the environment
- delaying visible confirmation too long
- emphasizing cosmetic effects more than state clarity

## AI Review Guidance

When reviewing game feel in this project, check:

- Is the interaction readable at every step?
- Are valid and invalid actions clearly distinguished?
- Is the environment state change easy to understand?
- Is replay/debug feedback helping comprehension?
- Can feedback be tuned without rewriting logic?
