# Hybrid Casual Skill

## Purpose
Help AI assistants design and implement hybrid casual games
that are easy to pick up, satisfying to play, and have enough depth to retain players.

## Core Idea
Hybrid casual sits between hypercasual and mid-core.
The core loop must be instantly understandable.
The meta layer must give players a reason to return.

## Definition
Hypercasual: one mechanic, no meta, high churn
Mid-core: deep systems, high barrier to entry
Hybrid casual: simple core + light progression meta

## Core Loop Structure
Every hybrid casual game needs:

```text
Action → Reward → Upgrade → Repeat
```

- Action: the main gameplay interaction (aim, merge, stack, shoot)
- Reward: currency, stars, level completion
- Upgrade: something visibly improves
- Repeat: the loop pulls the player back

## Core Mechanic Rules
The core mechanic must:
- Be understandable in under 5 seconds without tutorial text
- Feel good on the first interaction
- Have a clear success state and a clear failure state
- Be repeatable without feeling identical every time

If a new player cannot figure out what to do within 5 seconds,
the mechanic or its presentation needs work.

## Meta Layer Guidelines
Light meta systems that work well:
- Upgrade trees with visible impact (damage, speed, area)
- Base building or visual progression
- Loadout or equipment selection
- Character or skin unlocks

Avoid early:
- Complex crafting systems
- Multiple currencies before retention is proven
- Deep branching skill trees in early development

## Level Design Principles
- First 10 levels should teach, not challenge
- Difficulty should ramp gradually — spike after player understands the mechanic
- Fail states should feel fair, not random
- Short sessions (1-3 minutes per level) fit mobile play patterns
- Offer a clear sense of progress after every session

## Economy Design
Keep it simple early:

```text
One soft currency (coins, gems, stars)
One upgrade path visible immediately
One clear use for currency
```

Add complexity only after core retention is validated.

Common mistakes:
- Too many currencies confuse new players
- Upgrades with no visible gameplay impact feel unrewarding
- Paywalls too early before players are invested

## Game Feel for Hybrid Casual
Hybrid casual players expect:
- Immediate feedback on every action
- Satisfying completion moments (level end, upgrade purchase)
- Clear visual improvement after upgrades
- Short and punchy sound effects
- Progression that feels meaningful, not grind-heavy

Success should feel earned.
Failure should feel fair.
Upgrades should feel impactful.

## Retention Hooks
Common patterns that support retention:
- Daily login rewards
- Limited time events (implement late, after core loop is solid)
- Soft progression between sessions
- "One more level" pacing — end levels leaving the player wanting more

Do not implement retention systems before the core loop is fun.
Retention systems cannot fix a broken core loop.

## Monetization Awareness
Design with monetization in mind but do not block implementation on it:
- Leave clear hooks for rewarded ads (revive, bonus reward, skip wait)
- Design upgrade economy so IAP feels optional but attractive
- Avoid dark patterns — players who feel cheated churn permanently

## Technical Considerations for Hybrid Casual
- Session length targets: 2-5 minutes average
- Level completion should save immediately and reliably
- Economy state must persist correctly across sessions
- Upgrade effects must be immediately visible in gameplay
- A/B test hooks should be designed in early (difficulty, economy values)

## Tuning Values
Expose these as ScriptableObjects or config data:
- Level difficulty parameters
- Enemy or obstacle count and speed
- Currency drop rates
- Upgrade cost and effect scaling
- Session length targets per level

Never hardcode economy or difficulty values.

## AI Review Guidance
When reviewing hybrid casual features, check:
- Is the core action understandable without explanation?
- Does success feel satisfying?
- Does failure feel fair?
- Is the upgrade impact visible and meaningful?
- Are economy values exposed for tuning?
- Is the session length appropriate for mobile?
- Does the level leave the player wanting to play again?
