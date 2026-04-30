# Unity AI Workflow Kit

Build Unity games with AI without losing architectural control.

**Unity AI Workflow Kit** is a practical workflow system for Unity developers using AI coding tools like Codex, Claude Code, Cursor, GitHub Copilot, or similar assistants.

It provides agent roles, reusable skills, templates, and workflows that help AI tools understand how to build Unity projects with clean structure, maintainable code, and strong gameplay focus.

## Philosophy

Fast when needed.  
Clean by default.  
Production-minded when it matters.

This kit is not about generating messy prototypes as quickly as possible. It is about using AI as a disciplined development partner.

Early versions of a feature should stay simple, but they should not become spaghetti code. The goal is to move quickly while preserving a structure that can evolve.

## Core Principles

- Keep MonoBehaviours thin.
- Put gameplay rules in plain C# classes whenever possible.
- Follow OOP and SOLID principles where they add clarity.
- Avoid unnecessary abstraction during early iteration.
- Prefer simple clean solutions over complex perfect ones.
- Write code as if the prototype may later become production code.
- Review AI-generated code before trusting it.
- Make gameplay feel good, not just technically correct.

## Who Is This For?

This kit is designed mainly for:

- Solo Unity developers
- Small indie teams
- Mobile game developers
- Hybrid casual developers
- Steam indie developers
- AI-assisted game developers

The default focus is Unity development with strong mobile and gameplay-system awareness, but the structure can be adapted to almost any Unity project.

## What Is Included?

```text
unity-ai-workflow-kit/
  AGENTS.md
  agents/
  skills/
  templates/
  workflows/
```

### Agents

Role-based AI instructions such as:

- Unity Architect
- Gameplay Programmer
- Code Reviewer

### Skills

Reusable domain knowledge such as:

- Unity clean architecture
- Game feel
- State machines
- Object pooling
- Dependency injection
- Photon Fusion

### Templates

Documents that help convert ideas into implementation-ready plans:

- GDD
- TDD
- Feature specs
- Code review checklists

### Workflows

Step-by-step AI-assisted development flows:

- Idea to GDD
- GDD to TDD
- Feature development
- Refactoring
- Code review

## Recommended Unity Structure

This kit encourages a layered Unity project structure:

```text
Assets/
  _Project/
    Scripts/
      Core/
      Systems/
      Views/
      Data/
      UI/
      Installers/
    Tests/
```

### Core

Pure C# models, enums, value objects, rules, and messages.

### Systems

Gameplay logic and application logic. Prefer plain C# classes.

### Views

MonoBehaviours, input adapters, animation triggers, UI bindings, and Unity scene integration.

## How To Use

Copy the relevant files into your Unity project or AI tool context.

For example:

```text
AGENTS.md
agents/unity-architect.md
agents/gameplay-programmer.md
agents/code-reviewer.md
skills/unity-clean-architecture/SKILL.md
templates/GDD_TEMPLATE.md
templates/TDD_TEMPLATE.md
workflows/feature-development.md
```

Then ask your AI tool to follow the rules in `AGENTS.md` before generating or changing code.

## Example Prompt

```text
Use the rules in AGENTS.md.

Act as the Unity Architect first.
Review this feature idea and create a simple technical plan.

Feature:
The player can drag a ball, aim it with a trajectory line, release it, and bounce it into a target.
```

## What This Kit Is Not

This is not:

- A Unity package
- A framework
- A replacement for Unity knowledge
- A fully automated game generator

It is a practical workflow kit for controlling AI-assisted Unity development.

## License

MIT
