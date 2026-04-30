# 🚀 Unity AI Workflow Kit

Build Unity games with AI without losing architectural control.

![License](https://img.shields.io/badge/license-MIT-blue)
![Unity](https://img.shields.io/badge/Unity-Workflow-black)
![AI](https://img.shields.io/badge/AI-Assisted-purple)

---

## 🧠 What Is This?

**Unity AI Workflow Kit** is a practical workflow system for Unity developers using AI coding tools like Codex, Claude Code, Cursor, GitHub Copilot, or similar assistants.

It provides **agent roles, reusable skills, templates, and workflows** that help AI tools generate Unity code with:

* clean architecture
* maintainable structure
* strong gameplay focus
* production-aware decisions

This is not about blindly generating code.
This is about **controlling AI-assisted development**.

---

## 🎯 Why This Exists

Most AI tools can generate code.

But without structure, that code quickly becomes:

* bloated MonoBehaviours
* poor performance patterns
* hard-to-maintain systems
* inconsistent architecture

This kit helps you:

```text
Use AI without losing control of your codebase.
```

---

## ⚖️ Philosophy

Fast when needed.
Clean by default.
Production-minded when it matters.

This kit does **not** encourage messy prototypes.

Instead:

* Keep early implementations simple
* Avoid unnecessary abstraction
* Maintain clean structure from the start
* Write code that can evolve into production

> Do not overengineer early features,
> but never write code you would be ashamed to ship.

---

## 👤 Who Is This For?

* Solo Unity developers
* Indie teams
* Mobile & hybrid casual developers
* Steam indie developers
* Developers using AI tools in their workflow

---

## 📦 What’s Inside?

```text
unity-ai-workflow-kit/
  AGENTS.md
  agents/
  skills/
  templates/
  workflows/
```

### 🤖 Agents

Role-based AI instructions:

* Unity Architect
* Gameplay Programmer
* Code Reviewer
* Performance Reviewer
* Game Feel Reviewer
* Multiplayer Reviewer

---

### 🧩 Skills

Reusable knowledge modules:

* Unity clean architecture
* Game feel
* State machines
* Object pooling
* Dependency injection
* Photon Fusion
* Mobile development
* Hybrid casual design

---

### 📄 Templates

Structure your ideas before coding:

* Game Design Document (GDD)
* Technical Design Document (TDD)
* Feature specification
* Code review checklist

---

### 🔄 Workflows

Step-by-step development flows:

* Idea → GDD
* GDD → TDD
* Feature development
* Refactoring systems
* Multiplayer feature flow
* Code review flow

---

## ⚡ Quick Start

1. Copy `AGENTS.md` into your Unity project or AI context
2. Pick relevant agents from `/agents`
3. Use skills from `/skills` based on your feature
4. Define your feature using templates
5. Ask your AI assistant to follow the rules

### Example Prompt

```text
Use the rules in AGENTS.md.

Act as Unity Architect.

Create a technical plan for this feature:

Player drags a ball, aims it with a trajectory line, and releases it to hit a target.
```

---

## 🏗 Recommended Unity Structure

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

Pure C# logic, rules, and data.

### Systems

Gameplay logic and mechanics.

### Views

MonoBehaviours, UI, animations, input handling.

---

## 🎮 Game Feel Matters

A feature is not complete just because it works.

Always consider:

* responsiveness
* feedback
* timing
* clarity
* animation
* sound
* haptics

---

## 🧪 Example (Coming Soon)

Example implementations will be added under:

```text
examples/
```

---

## ❌ What This Is NOT

* Not a Unity plugin
* Not a game framework
* Not a one-click game generator
* Not a replacement for real Unity knowledge

---

## 📜 License

MIT License
