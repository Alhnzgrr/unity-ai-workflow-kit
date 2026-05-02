# Unity AI Workflow Kit

Build Unity projects with AI without losing architectural control.

![License](https://img.shields.io/badge/license-MIT-blue)
![Unity](https://img.shields.io/badge/Unity-Workflow-black)
![AI](https://img.shields.io/badge/AI-Assisted-purple)

---

## What Is This?

**Unity AI Workflow Kit** is a practical workflow system for Unity developers using AI coding tools such as Codex, Claude Code, Cursor, GitHub Copilot, or similar assistants.

It provides:

- agent roles
- reusable skills
- templates
- workflows
- Unity-specific guardrail hooks

The goal is not blind code generation.

The goal is structured AI-assisted Unity development.

---

## Why This Exists

AI tools can generate code quickly.

Without structure, that code often becomes:

- bloated MonoBehaviours
- inconsistent architecture
- weak performance patterns
- hard-to-maintain systems
- unclear boundaries between runtime, editor, and data

This kit helps you use AI without losing control of your Unity project.

---

## Philosophy

Fast when needed.
Clean by default.
Production-minded when it matters.

This kit does not encourage messy prototypes.

Instead:

- keep early implementations simple
- avoid unnecessary abstraction
- maintain clean structure from the start
- write code that can evolve into production

> Do not overengineer early features, but never write code you would be ashamed to ship.

---

## Who Is This For?

- solo Unity developers
- indie teams
- mobile and hybrid-casual developers
- developers using AI tools in their workflow
- teams building rule-driven Unity environments, simulations, and tooling

---

## What's Inside?

```text
unity-ai-workflow-kit/
  AGENTS.md
  agents/
  commands/
  hooks/
  runtime/
  rules/
  skills/
  templates/
  workflows/
```

### Agents

Role-based AI instructions:

- Unity Architect
- Gameplay Programmer
- Code Reviewer
- Performance Reviewer
- Game Feel Reviewer

### Skills

Skills are organized by responsibility:

```text
skills/
  unity-core/
  unity-architecture/
  training/
  design/
  learned/
```

#### unity-core

Reusable Unity implementation knowledge:

- object pooling
- mobile development
- scriptable objects
- serialization safety
- input system
- assembly definitions
- editor/runtime separation

#### unity-architecture

Project structure and environment/system design:

- unity clean architecture
- state machine
- dependency injection
- environment-view separation
- simulation loop

#### training

Reasoning and evaluation skills for rule-driven environments:

- state analysis
- action validation
- reward analysis
- termination check
- failure diagnosis
- episode review

#### design

Interaction and product-facing design support:

- game feel
- hybrid casual

#### learned

The `skills/learned/` folder is reserved for project-specific patterns discovered over time.

Use it for:

- repeated project-specific conventions
- environment-specific pitfalls
- stable patterns that do not belong in general Unity skills

Do not use it for:

- generic Unity guidance
- generic AI reasoning guidance
- one-off notes or temporary experiments

Only add a learned skill when the pattern is:

- repeated
- high-signal
- specific to this project or workflow
- useful enough to prevent the same mistake from happening again

### Hooks

The `hooks/` folder contains repository guardrails for high-cost Unity mistakes.

Current hook set:

- `block-serialized-unity-edit`
- `guard-editor-runtime`
- `check-core-boundary`
- `warn-serialized-rename`
- `check-input-boundary`

These hooks are intended to protect:

- serialized Unity files
- editor/runtime separation
- Core and Environment layer boundaries
- input architecture discipline
- serialization migration safety

### Rules

The `rules/` folder contains non-negotiable engineering standards for opinionated Unity AI workflows.

Current rule set:

- `architecture`
- `dependency-injection`
- `async`
- `unity-runtime`
- `serialization`
- `performance`
- `workflow-orchestration`

These rules are intended to enforce:

- explicit architecture boundaries
- selected DI container discipline
- UniTask-only async
- no scene-search fallback setup
- serialization safety
- performance-aware implementation
- phase-based workflow discipline

### Commands

The `commands/` folder contains reusable operation prompts for common AI workflows.

Current command set:

- `architect`
- `plan-workflow`
- `review-code`
- `validate`
- `learn`
- `orchestrate`
- `build-feature`
- `catch-up`

These commands are intended to help AI assistants:

- design before coding
- break large work into small execution steps
- review code with consistent quality gates
- validate milestone readiness
- extract repeated project-specific patterns
- coordinate multi-phase feature workflows
- resume partially completed tasks cleanly

### Templates

Structure your ideas before coding:

- Game Design Document (GDD)
- Technical Design Document (TDD)

The `templates/` folder also contains handoff templates for agent-to-agent workflow:

- architecture handoff
- implementation handoff
- setup handoff
- test handoff
- review handoff
- validation report

### Runtime

The `runtime/` folder is reserved for workflow artifacts produced during multi-phase work:

- `tasks/`
- `handoffs/`
- `reviews/`
- `validations/`
- `logs/`

This makes the kit ready for orchestration-oriented workflows instead of one-shot prompting only.

### Workflows

Step-by-step development flows:

- feature development

---

## Quick Start

1. Load `AGENTS.md` into your AI context.
2. Pick the relevant agent from `agents/`.
3. Load only the skills relevant to the current task.
4. Use templates and workflows to define the work clearly.
5. Keep hook guardrails in mind when editing Unity projects.

### Example Prompt

```text
Use the rules in AGENTS.md.

Act as Unity Architect.

Design the system for this feature:

Player drags a ball, aims it with a trajectory line, and releases it to hit a target.
```

---

## Recommended Unity Structure

For gameplay-heavy projects:

```text
Assets/
  _Project/
    Scripts/
      Core/
      Environment/
      Views/
      Data/
      Composition/
    Tests/
```

For rule-driven environments or simulations, prefer:

- `Core`: state, actions, rules, reward logic, termination logic
- `Environment`: reset, validation, step flow, transition systems
- `Views`: MonoBehaviours, UI, input adapters, debug visualization
- `Data`: ScriptableObjects, configs, scenarios
- `Composition`: runtime wiring and setup

---

## Game Feel Matters

A feature is not complete just because it works.

Always consider:

- responsiveness
- feedback clarity
- valid vs invalid action feedback
- state readability
- replay/debug readability
- sound and haptics where appropriate

---

## What This Is Not

- not a Unity plugin
- not a full game framework
- not a one-click generator
- not a replacement for real Unity knowledge

---

## License

MIT License
