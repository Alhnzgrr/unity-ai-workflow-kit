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

REVIEW  
Agent: Code Reviewer  
Input: implemented code  
Output: Must Fix / Should Improve / Optional

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

### Full pipeline prompt

Use `agents/unity-architect.md`, `agents/gameplay-programmer.md`, `agents/code-reviewer.md`.  
Step 1: Act as Unity Architect. Design this feature: [description]  
Step 2: Act as Gameplay Programmer. Implement the design from Step 1.  
Step 3: Act as Code Reviewer. Review the code from Step 2.

---

## Agent Combination Rules

| Situation | Agents to combine |
|---|---|
| Mobile-critical system | Performance Reviewer + Game Feel Reviewer |
| Core gameplay mechanic | Architect + Gameplay Programmer + Game Feel Reviewer |
| Rule-driven environment or simulation | Architect + Gameplay Programmer + Code Reviewer |
| Legacy code cleanup | Code Reviewer + Architect |

---

## Context Management

AI tools have limited context windows.

Load only what you need per session:

- For design sessions: `AGENTS.md` + `agents/unity-architect.md` + relevant skills
- For implementation: `AGENTS.md` + `agents/gameplay-programmer.md` + relevant skills
- For review: `AGENTS.md` + `agents/code-reviewer.md`
- For full pipeline: load agents one at a time per step

Do not load all agents and all skills at once.

This reduces response quality.

---

## Command Reference

Use `commands/` when you want a reusable workflow entrypoint instead of a free-form prompt.

Current command set:

- `commands/architect.md`
- `commands/plan-workflow.md`
- `commands/review-code.md`
- `commands/validate.md`
- `commands/learn.md`

Suggested use:

- use `architect` before implementing non-trivial systems
- use `plan-workflow` after design to break work into safe steps
- use `review-code` after implementation or refactor
- use `validate` before declaring a milestone complete
- use `learn` when a repeated project-specific pattern appears

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
