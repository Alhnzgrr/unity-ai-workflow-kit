---
name: unity-ai-workflow-kit
description: Use Unity AI Workflow Kit in Unity projects to route work through agents, rules, templates, validation gates, and project-local runtime artifacts.
---

# Unity AI Workflow Kit Adapter for Codex

Use this adapter when working in a Unity project that has `Assets/unity-ai-workflow-kit` installed.

## Startup

1. Read `Assets/unity-ai-workflow-kit/AGENTS.md`.
2. Select only the agent files required for the current task.
3. Load only the relevant rules and skills.
4. Use runtime artifacts for medium or large tasks.

## Routing

- New feature or unclear design: use `agents/unity-architect.md`.
- Implementation after design: use `agents/gameplay-programmer.md`.
- Scene, prefab, asset, or inspector wiring: use `agents/unity-setup.md`.
- Code review: use `agents/code-reviewer.md`.
- Test planning and validation: use `agents/tester.md`.
- Mobile or hot-path risk: use `agents/performance-reviewer.md`.
- Interaction clarity or feedback quality: use `agents/game-feel-reviewer.md`.

## Gates

- Serialized field or asset change: load `rules/serialization.md`.
- MonoBehaviour, lifecycle, scene, prefab, or runtime Unity work: load `rules/unity-runtime.md`.
- Dependency wiring: load `rules/dependency-injection.md`.
- Async, timer, delay, or cancellation flow: load `rules/async.md`.
- Allocation, Update loop, pooling, or mobile risk: load `rules/performance.md`.
- Medium or large workflow: load `rules/workflow-orchestration.md`.

## Runtime Artifacts

For non-trivial work, write artifacts under:

```text
Assets/unity-ai-workflow-kit/runtime/
```

Use this naming pattern:

```text
YYYY-MM-DD-feature-name.task.md
YYYY-MM-DD-feature-name.architecture.md
YYYY-MM-DD-feature-name.code-review.md
YYYY-MM-DD-feature-name.validation.md
```
