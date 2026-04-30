# AGENTS.md

This file defines the default behavior for AI coding assistants working on Unity projects that use this workflow kit.

## Mission

Help build Unity games with clean architecture, strong gameplay feel, and maintainable code.

AI assistants should support development, not take architectural control away from the developer.

## Development Philosophy

Fast when needed.  
Clean by default.  
Production-minded when it matters.

Do not overengineer early features, but never write throwaway or messy code.

Prefer a simple clean solution over a complex perfect one.

Write code as if the current prototype may later evolve into a real production project.

## Unity Architecture Rules

### MonoBehaviour Usage

MonoBehaviours should be thin.

Use MonoBehaviours mainly for:

- Unity lifecycle methods
- Scene references
- Input adapters
- Animation triggers
- View updates
- Collision callbacks
- Inspector configuration

Avoid putting large gameplay rules directly inside MonoBehaviours.

### Gameplay Logic

Gameplay logic should live in plain C# classes when possible.

Good places for logic:

```text
Core/
Systems/
Services/
Rules/
StateMachines/
```

Avoid making every feature depend directly on Unity scene objects.

### Separation of Concerns

Keep responsibilities focused.

A class should not handle:

- input
- movement
- scoring
- UI
- saving
- audio
- spawning

all at the same time.

If a class grows beyond a few clear responsibilities, split it.

### SOLID / OOP

Follow SOLID principles where they improve clarity and maintainability.

Use interfaces when they create useful boundaries, not just because they look clean.

Avoid abstraction for abstraction's sake.

### Dependency Management

Prefer explicit dependencies.

If a project uses Dependency Injection, follow the existing DI approach.

Zenject may be used as a reference, but the architecture should stay DI-framework independent.

Avoid hidden dependencies such as:

- global mutable state
- excessive singletons
- `FindObjectOfType` in gameplay logic
- hardcoded scene lookups in systems

## Performance Guidelines

Be careful in hot paths:

- `Update`
- `FixedUpdate`
- `LateUpdate`
- frequent input handling
- physics queries
- spawning/despawning
- UI refresh loops

Avoid unnecessary allocations in hot paths:

- LINQ
- repeated string creation
- new collections
- boxing
- frequent Instantiate/Destroy
- repeated GetComponent calls without caching

Use object pooling where it improves performance and clarity.

## Mobile Awareness

For mobile or hybrid casual games:

- Prioritize clear input
- Keep sessions readable and responsive
- Avoid heavy per-frame logic
- Watch draw calls, overdraw, and UI rebuilds
- Make feedback immediate
- Keep the core loop understandable within seconds

## Game Feel Rules

A feature is not done only because it works.

Consider:

- timing
- feedback
- anticipation
- impact
- camera response
- animation
- sound
- haptics
- UI clarity

Always mention missing game-feel opportunities when reviewing gameplay features.

## AI Code Output Rules

When writing code:

1. Explain the intent briefly.
2. Keep changes scoped.
3. Respect the existing project style.
4. Avoid rewriting unrelated systems.
5. Mention assumptions.
6. Mention Unity lifecycle implications.
7. Mention possible compile risks.
8. Suggest tests or manual validation steps.

## Review Rules

When reviewing code, check:

- correctness
- architecture
- class responsibility
- Unity lifecycle usage
- performance
- memory allocations
- testability
- game-feel implications
- mobile risks
- multiplayer authority risks, if applicable

## Multiplayer Rules

For Photon Fusion or similar networking:

- Never change networked state without authority checks.
- Separate local prediction from authoritative state.
- Be explicit about RPC direction and ownership.
- Avoid mixing UI, input, and network state in one class.
- Consider host migration, disconnects, and late joiners where relevant.

## Final Rule

Do not blindly generate more code.

If the design is unclear, first produce a small plan and identify risks.
