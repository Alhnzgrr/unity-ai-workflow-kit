# Async Rules

## Core Rule

Use `UniTask` for async and delayed flows.

Do not use:

- coroutines
- `Task`
- `Task<T>`
- `async void`, except where Unity event signatures make it unavoidable and the risk is explicitly handled

## UniTask Only

`UniTask` is the standard async abstraction for this kit.

Reasons:

- better Unity integration
- cancellation support
- fewer lifecycle surprises than coroutines
- no split async style across the codebase

## Non-Negotiable Rules

- No `StartCoroutine`
- No `IEnumerator`-driven feature flow for runtime logic
- No `yield return`-based orchestration for gameplay or environment systems
- No plain `Task.Run` for Unity-facing logic
- No mixing `Task` and `UniTask` without a strong boundary reason

## Cancellation

Async flows must have an ownership model.

- views should use destruction-aware cancellation
- systems should own and dispose their cancellation sources
- long-running operations must define who cancels them and when

## Threading

Unity API remains main-thread only.

- background work may prepare data
- Unity objects, components, transforms, and scene operations must return to main thread before use

## Good Patterns

- `UniTask.Delay(...)` with cancellation
- `UniTask.WhenAll(...)` for coordinated async work
- explicit cancellation source in long-lived systems
- clear async boundary between non-Unity work and Unity object interaction

## Bad Patterns

- coroutine chains for core feature flow
- `Task.Delay` inside Unity feature code
- fire-and-forget async with no owner
- delayed work that keeps running after the view or system is gone

## AI Review Guidance

When reviewing async code, check:

- Is UniTask used consistently?
- Is coroutine or Task usage creeping in?
- Is cancellation ownership clear?
- Does the async flow respect Unity main-thread rules?
