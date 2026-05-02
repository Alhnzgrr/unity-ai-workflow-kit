# Performance Rules

## Core Principle

Performance is part of feature design, not just cleanup after the feature works.

## Hot Path Discipline

In hot paths such as `Update`, `FixedUpdate`, and frequently triggered UI refresh loops:

- avoid heap allocations
- avoid repeated lookup calls
- avoid hidden scene searches
- avoid repeated string work

## Non-Negotiable Rules

- No `Find*` lookups in hot paths
- No `GetComponent*` churn in hot paths unless the cost and frequency are justified and reviewed
- No LINQ in gameplay or environment hot paths
- No repeated instantiate/destroy for frequently reused visuals when pooling is appropriate

## Cache Intentionally

Cache stable references that are guaranteed by local composition or required components.

Do not confuse caching with fallback lookup.

This is good:

```text
Component is guaranteed locally
-> get it once during owned initialization
-> reuse it
```

This is bad:

```text
Dependency was not assigned
-> search for it dynamically
-> cache the accidental recovery
```

## Rendering Awareness

Architecture should account for:

- draw calls
- material sharing
- sprite atlasing
- pooled UI and feedback elements
- canvas rebuild cost
- mobile constraints

## Mobile Bias

If the feature targets mobile:

- assume tighter CPU and GPU budgets
- keep debug and overlay tooling lightweight
- avoid unnecessary update churn
- split frequently changing UI from static UI when helpful

## Good Patterns

- explicit pooling for repeated transient visuals
- cached component references with guaranteed ownership
- clear rendering strategy in architecture work
- performance checks during review, not only at the end

## Bad Patterns

- startup manager that finds many objects and keeps doing lookups
- hidden allocations in per-frame logic
- solving architecture mistakes with repeated runtime searches
- ignoring draw-call and UI rebuild implications until late

## AI Review Guidance

When reviewing performance-sensitive code, check:

- Are there hidden lookups or allocations in hot paths?
- Is pooling used where repeated reuse is expected?
- Is mobile impact considered?
- Is the code paying runtime cost to compensate for weak wiring?
