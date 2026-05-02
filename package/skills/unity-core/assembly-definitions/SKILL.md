# Assembly Definitions Skill

## Purpose

Help AI assistants use Unity assembly definitions to enforce cleaner boundaries between environment logic, Unity views, authoring code, and tests.

## Core Idea

If architectural boundaries matter, assembly boundaries can help protect them.

In this project, assembly definitions are useful for keeping:

- core environment logic
- Unity-facing views and adapters
- editor-only tooling
- tests

separate at compile time.

## Why Use Assembly Definitions

Assembly definitions help:

- reduce accidental dependencies
- improve compile-time separation
- speed up iteration on larger projects
- make test boundaries clearer

They are especially useful when the project has:

- plain C# environment logic
- Unity presentation and debug layers
- editor-only utilities
- dedicated test assemblies

## Recommended Assembly Split

Start simple.

A practical split for this project is:

```text
Project.Core
  State, actions, observations, rules, reward logic, termination logic

Project.Environment
  Simulation loop, validation, transition systems, environment coordination

Project.Unity
  MonoBehaviours, input adapters, debug views, UI, visualization

Project.Editor
  Custom inspectors, editor tools, authoring helpers

Project.Tests
  EditMode and PlayMode test assemblies
```

## Dependency Direction

Prefer:

```text
Project.Unity -> Project.Environment -> Project.Core
Project.Editor -> Project.Unity / Project.Environment as needed
Project.Tests -> whichever assembly is under test
```

Rules:

- `Project.Core` should not depend on Unity scene/view code.
- `Project.Environment` should not require editor-only code.
- `Project.Editor` must stay editor-only.
- Tests should reference the minimum required assemblies.

## Good Outcome

If a developer tries to use a view type inside core logic, the assembly boundary should make that mistake obvious.

That is valuable.

## When To Use

Use assembly definitions when:

- the project has real layer boundaries
- you want Core to stay plain C#
- editor tooling exists
- test assemblies should stay focused

Do not over-split when:

- the project is still tiny
- boundaries are not stable yet
- assembly churn would slow understanding more than it helps

## Unity-Specific Guidance

- Put editor-only code in a dedicated editor assembly.
- Keep runtime environment logic out of editor folders and editor assemblies.
- Use test assemblies to separate EditMode and PlayMode concerns when useful.
- Keep the first assembly split small and meaningful.

## Suggested First Step

If the project is early, start with:

- one core assembly
- one unity/runtime assembly
- one editor assembly
- one tests assembly

Then split further only if the environment/runtime layer grows enough to justify it.

## Common Mistakes

- making too many assemblies too early
- creating boundaries that do not reflect real architecture
- putting editor helpers in runtime assemblies
- letting Unity-facing assemblies leak into core logic
- forcing tests to reference the whole project unnecessarily

## AI Review Guidance

When reviewing assembly definitions, check:

- Do the assemblies reflect real architecture?
- Is core logic protected from Unity view dependencies?
- Is editor code separated cleanly?
- Are tests referencing only what they need?
- Is the split simple enough to maintain?
