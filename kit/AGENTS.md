# Unity AI Workflow Kit - AGENTS.md

## Overview

This file defines the agent roles and coordination flow for AI-assisted Unity development.

Use this file as the primary context for your AI assistant.

---

## Agent Roster

| Agent | File | Responsibility |
|---|---|---|
| Unity Architect | agents/unity-architect.md | System design, class boundaries, data flow |
| Gameplay Programmer | agents/gameplay-programmer.md | Feature implementation |
| Tester | agents/tester.md | Test planning, coverage, validation flow |
| Unity Setup | agents/unity-setup.md | Scene, prefab, asset, and wiring setup |
| Code Reviewer | agents/code-reviewer.md | Code quality, architecture, correctness |
| Performance Reviewer | agents/performance-reviewer.md | Allocations, draw calls, mobile performance |
| Game Feel Reviewer | agents/game-feel-reviewer.md | Feedback, timing, interaction clarity |

---

## When To Use Which Agent

### Starting a new feature

Start with **Unity Architect**.

Use when: you have an idea but no technical plan yet.

Ask for: system design, class list, data flow, risks.

### Implementing a designed feature

Use **Gameplay Programmer**.

Use when: you have a technical plan and need working code.

Ask for: implementation, tuning values, Unity setup steps, feedback hooks.

### Reviewing existing or generated code

Use **Code Reviewer**.

Use when: code is written and needs quality check.

Ask for: correctness, architecture, lifecycle safety, test gaps.

### Planning or reviewing tests

Use **Tester**.

Use when: you need test coverage, validation scope, edge-case review, or manual smoke test steps.

Ask for: EditMode test targets, integration risks, edge cases, and validation coverage gaps.

### Preparing scene, prefab, or asset setup

Use **Unity Setup**.

Use when: a feature needs scene wiring, prefab references, ScriptableObject setup, or explicit Unity Editor steps.

Ask for: scene hierarchy, required components, reference assignments, installer wiring, and smoke test setup.

### Reviewing for mobile performance

Use **Performance Reviewer**.

Use when: feature is implemented and you want to check mobile impact.

Ask for: allocation check, draw call audit, mobile-specific risks.

### Reviewing for player or operator experience

Use **Game Feel Reviewer**.

Use when: the feature works and you want to evaluate clarity, responsiveness, and feedback quality.

Ask for: feedback gaps, timing issues, readability, valid/invalid action clarity, haptic and audio opportunities.

---

## Standard Feature Flow

Use this flow for any non-trivial feature:

DESIGN  
Agent: Unity Architect  
Input: feature description in plain language  
Output: class list, responsibilities, data flow, risks

IMPLEMENT  
Agent: Gameplay Programmer  
Input: architect output + feature description  
Output: working code, Unity setup steps, tuning values

SETUP  
Agent: Unity Setup  
Input: implemented code + architecture notes  
Output: scene/prefab/asset wiring steps, required references, Unity Editor checklist

REVIEW  
Agent: Code Reviewer  
Input: implemented code  
Output: Must Fix / Should Improve / Optional

TEST CHECK  
Agent: Tester  
Input: implemented code or feature scope  
Output: automated test targets, manual validation steps, coverage gaps

PERFORMANCE CHECK  
Agent: Performance Reviewer  
Input: reviewed code  
Output: Critical issues / Watch list / Mobile checklist

FEEL CHECK  
Agent: Game Feel Reviewer  
Input: working feature in context  
Output: Missing feedback / Polish opportunities

---

## Quick Flow

For small, low-risk features:

IMPLEMENT  
Agent: Gameplay Programmer

REVIEW  
Agent: Code Reviewer

TEST CHECK  
Agent: Tester

FEEL CHECK  
Agent: Game Feel Reviewer

Use Quick Flow when:

- the feature touches only one system
- no new classes are needed
- architectural risk is low

---

## Refactor Flow

Use when improving existing code without adding new behavior:

REVIEW  
Agent: Code Reviewer  
Goal: identify what needs to change and why

DESIGN (if structural changes are needed)  
Agent: Unity Architect  
Goal: plan the refactored structure

IMPLEMENT  
Agent: Gameplay Programmer  
Goal: apply the refactor cleanly

TEST CHECK  
Agent: Tester  
Goal: confirm regression-sensitive areas and missing validation

---

## Example Prompts

### Starting a feature

Use `agents/unity-architect.md`.  
Act as Unity Architect.  
Design the system for this feature:  
[describe your feature here]

### Implementing a feature

Use `agents/gameplay-programmer.md`.  
Act as Gameplay Programmer.  
Here is the technical plan:  
[paste architect output]  
Implement this feature.

### Reviewing code

Use `agents/code-reviewer.md`.  
Act as Code Reviewer.  
Review this code:  
[paste code]

### Planning tests

Use `agents/tester.md`.  
Act as Tester.  
Plan the tests and validation steps for this feature:  
[paste scope or code]

### Preparing Unity setup

Use `agents/unity-setup.md`.  
Act as Unity Setup.  
List the scene, prefab, asset, and wiring setup needed for this feature:  
[paste plan or code]

### Full pipeline prompt

Use `agents/unity-architect.md`, `agents/gameplay-programmer.md`, `agents/unity-setup.md`, `agents/code-reviewer.md`, `agents/tester.md`.  
Step 1: Act as Unity Architect. Design this feature: [description]  
Step 2: Act as Gameplay Programmer. Implement the design from Step 1.  
Step 3: Act as Unity Setup. Define the required Unity setup from Step 2.  
Step 4: Act as Code Reviewer. Review the code from Step 2.  
Step 5: Act as Tester. Define tests and validation for the feature.

---

## Agent Combination Rules

| Situation | Agents to combine |
|---|---|
| Mobile-critical system | Performance Reviewer + Game Feel Reviewer |
| Core gameplay mechanic | Architect + Gameplay Programmer + Game Feel Reviewer |
| Rule-driven environment or simulation | Architect + Gameplay Programmer + Code Reviewer |
| Scene-heavy feature or prefab wiring | Gameplay Programmer + Unity Setup + Code Reviewer |
| Regression-sensitive feature | Gameplay Programmer + Tester + Code Reviewer |
| Legacy code cleanup | Code Reviewer + Architect |

---

## Decision Gates

Use these gates to avoid skipping required workflow steps:

| Trigger | Required action |
|---|---|
| New or unclear feature | Start with Unity Architect |
| Scene, prefab, ScriptableObject, or inspector wiring | Include Unity Setup |
| Serialized field, prefab, scene, or asset change | Load `rules/serialization.md` |
| MonoBehaviour lifecycle or scene-facing code | Load `rules/unity-runtime.md` |
| Dependency wiring or service composition | Load `rules/dependency-injection.md` |
| Async, timer, delay, cancellation, or sequencing | Load `rules/async.md` |
| Update loop, pooling, allocation, draw call, or mobile risk | Include Performance Reviewer |
| Input behavior, feedback, animation, sound, haptics, or clarity | Include Game Feel Reviewer |
| Rule-driven environment or simulation | Load relevant `skills/training/` and simulation skills |
| Medium or large task | Create runtime artifacts and validation report |

---

## Context Management

AI tools have limited context windows.

Load only what you need per session:

- For design sessions: `AGENTS.md` + `agents/unity-architect.md` + relevant skills
- For implementation: `AGENTS.md` + `agents/gameplay-programmer.md` + relevant skills
- For Unity setup: `AGENTS.md` + `agents/unity-setup.md` + relevant rules/skills
- For testing: `AGENTS.md` + `agents/tester.md` + relevant rules/skills
- For review: `AGENTS.md` + `agents/code-reviewer.md`
- For full pipeline: load agents one at a time per step

Do not load all agents and all skills at once.

This reduces response quality.

### Session Loading Policy

At the start of a session, load `AGENTS.md` once.

For each task:

- Reuse agent, rule, and skill files already loaded earlier in the same session.
- Re-read a kit file only when the task needs a different role, rule, or skill.
- Re-read a kit file if the user says the kit changed or if the file may have changed.
- For small follow-up tasks, do not reload kit files unless the task scope changes.
- If a file has already been read in the same session, summarize from the existing context instead of reading it again.

---

## Command Reference

Use `commands/` when you want a reusable workflow entrypoint instead of a free-form prompt.

Current command set:

- `commands/architect.md`
- `commands/plan-workflow.md`
- `commands/review-code.md`
- `commands/validate.md`
- `commands/learn.md`
- `commands/orchestrate.md`
- `commands/build-feature.md`
- `commands/catch-up.md`

Suggested use:

- use `architect` before implementing non-trivial systems
- use `plan-workflow` after design to break work into safe steps
- use `review-code` after implementation or refactor
- use `validate` before declaring a milestone complete
- use `learn` when a repeated project-specific pattern appears
- use `orchestrate` for multi-phase feature coordination
- use `build-feature` for end-to-end feature flow
- use `catch-up` when resuming a task or reconstructing workflow state

---

## Handoff And Artifacts

The installed kit also supports handoff-driven workflow progression.

Handoff templates:

- `templates/architecture-handoff.md`
- `templates/implementation-handoff.md`
- `templates/setup-handoff.md`
- `templates/test-handoff.md`
- `templates/review-handoff.md`
- `templates/validation-report.md`

Runtime artifact folders:

- `runtime/tasks/`
- `runtime/handoffs/`
- `runtime/reviews/`
- `runtime/validations/`
- `runtime/logs/`

Use these when a feature should move through multiple agents with explicit phase outputs and review gates.

---

## Rules Reference

The repository also includes `rules/` for non-negotiable engineering constraints.

Current rule set:

- `rules/architecture.md`
- `rules/dependency-injection.md`
- `rules/async.md`
- `rules/unity-runtime.md`
- `rules/serialization.md`
- `rules/performance.md`
- `rules/workflow-orchestration.md`

Suggested use:

- load `dependency-injection` when wiring systems, views, and services
- load `async` when building delayed or asynchronous feature flow
- load `unity-runtime` when authoring MonoBehaviour setup and scene-facing code
- load `serialization` before renaming inspector-backed fields
- load `performance` for mobile-sensitive or hot-path work
- load `workflow-orchestration` for medium or large tasks and when phase discipline matters

---

## Skills Reference

| Situation | Recommended Skills |
|---|---|
| New system | `skills/unity-architecture/unity-clean-architecture/SKILL.md` |
| Environment and view separation | `skills/unity-architecture/environment-view-separation/SKILL.md` |
| Rule-driven step flow | `skills/unity-architecture/simulation-loop/SKILL.md` |
| Object management | `skills/unity-core/object-pooling/SKILL.md` |
| Input-driven feature | `skills/unity-core/input-system/SKILL.md` |
| Config and scenario authoring | `skills/unity-core/scriptable-objects/SKILL.md` |
| Serialization-sensitive change | `skills/unity-core/serialization-safety/SKILL.md` |
| Mobile feature | `skills/unity-core/mobile-development/SKILL.md` |
| Gameplay or environment state flow | `skills/unity-architecture/state-machine/SKILL.md` |
| Dependency wiring | `skills/unity-architecture/dependency-injection/SKILL.md` |
| Agent reasoning and evaluation | `skills/training/` |
| Interaction clarity and feedback | `skills/design/game-feel/SKILL.md` |
| Hybrid-casual product direction | `skills/design/hybrid-casual/SKILL.md` |

---

## Hooks Reference

The repository also includes `hooks/` for Unity-specific guardrails.

Current hook set:

- `hooks/block-serialized-unity-edit.sh`
- `hooks/guard-editor-runtime.sh`
- `hooks/check-core-boundary.sh`
- `hooks/warn-serialized-rename.sh`
- `hooks/check-input-boundary.sh`

Use these as repository guardrails for:

- serialized asset safety
- editor/runtime separation
- core architecture boundary protection
- input architecture discipline

---

## Learned Skills

`skills/learned/` is reserved for repeated, project-specific patterns discovered over time.

Add a learned skill only when the pattern is:

- repeated
- project-specific
- high-signal
- useful enough to prevent the same mistake again
