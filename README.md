# Unity AI Workflow Kit

Build Unity projects with AI without losing architectural control.

![License](https://img.shields.io/badge/license-MIT-blue)
![Unity](https://img.shields.io/badge/Unity-Workflow-black)
![AI](https://img.shields.io/badge/AI-Assisted-purple)

---

## What Is This?

**Unity AI Workflow Kit** is a source repository for installing a project-local AI workflow system into Unity projects.

It is not a Unity Package Manager package.

The repository is the source of truth. A Unity project receives an installed copy under:

```text
Assets/unity-ai-workflow-kit/
```

AI tools can then use that installed kit through thin adapters for Codex, Claude Code, Cursor, or similar tools.

---

## Why This Exists

AI tools can generate code quickly.

Without workflow constraints, that code often becomes:

- bloated MonoBehaviours
- inconsistent architecture
- weak performance patterns
- hard-to-maintain systems
- unclear runtime/editor boundaries
- missing review and validation evidence

This kit uses roles, rules, templates, gates, hooks, and runtime artifacts to make AI-assisted Unity development more deliberate.

---

## Model

Source of truth:

```text
unity-ai-workflow-kit/
```

Installed Unity project artifact:

```text
UnityProject/Assets/unity-ai-workflow-kit/
```

Installed AI tool adapter:

```text
.codex/
.claude/
.cursor/
```

The source repo contains reusable content and installers. The Unity project contains project-specific runtime artifacts such as tasks, handoffs, reviews, validations, and logs.

---

## Repository Layout

```text
unity-ai-workflow-kit/
  AGENTS.md
  README.md

  kit/
    AGENTS.md
    agents/
    commands/
    hooks/
    rules/
    skills/
    templates/
    workflows/
    runtime-template/

  adapters/
    codex/
    claude/
    cursor/

  scripts/
    install-unity-project.ps1
    install-codex-adapter.ps1
    install-claude-adapter.ps1
    install-cursor-adapter.ps1
    validate-install.ps1

  docs/
  dist/
```

### kit

Tool-agnostic workflow content.

This is what gets installed into a Unity project as `Assets/unity-ai-workflow-kit`.

### adapters

Thin AI-tool-specific integration files.

Adapters should teach the AI tool how to find and use the installed kit. They should not duplicate the whole kit.

### scripts

Install and validation automation.

### dist

Reserved for generated output.

### docs

Architecture and installation notes.

---

## Install Into A Unity Project

Run from this repository:

```powershell
.\scripts\install-unity-project.ps1 -ProjectPath "C:\Path\To\UnityProject"
```

This creates or updates:

```text
UnityProject/Assets/unity-ai-workflow-kit/
```

Validate the install:

```powershell
.\scripts\validate-install.ps1 -ProjectPath "C:\Path\To\UnityProject"
```

---

## Install Codex Adapter

Run:

```powershell
.\scripts\install-codex-adapter.ps1
```

This creates or updates:

```text
%USERPROFILE%\.codex\skills\unity-ai-workflow-kit\
```

## Install Claude Or Cursor Adapter

Run:

```powershell
.\scripts\install-claude-adapter.ps1 -ProjectPath "C:\Path\To\UnityProject"
.\scripts\install-cursor-adapter.ps1 -ProjectPath "C:\Path\To\UnityProject"
```

---

## Installed Kit Contents

After installation, the Unity project receives:

```text
Assets/unity-ai-workflow-kit/
  AGENTS.md
  agents/
  commands/
  hooks/
  rules/
  skills/
  templates/
  workflows/
  runtime/
```

Start by loading `Assets/unity-ai-workflow-kit/AGENTS.md` into your AI tool context.

---

## Runtime Artifacts

Runtime artifacts belong to the Unity project, not this source repository.

Use this naming pattern:

```text
Assets/unity-ai-workflow-kit/runtime/tasks/YYYY-MM-DD-feature-name.task.md
Assets/unity-ai-workflow-kit/runtime/handoffs/YYYY-MM-DD-feature-name.architecture.md
Assets/unity-ai-workflow-kit/runtime/reviews/YYYY-MM-DD-feature-name.code-review.md
Assets/unity-ai-workflow-kit/runtime/validations/YYYY-MM-DD-feature-name.validation.md
```

---

## Decision Gates

Use these checks to avoid skipping required workflow phases:

| Trigger | Required gate |
|---|---|
| New or unclear feature | Unity Architect |
| Scene, prefab, ScriptableObject, or inspector wiring | Unity Setup |
| Serialized field, prefab, scene, or asset change | Serialization rule |
| MonoBehaviour lifecycle or scene-facing code | Unity runtime rule |
| Dependency wiring or service composition | Dependency injection rule |
| Async, timer, delay, cancellation, or sequencing | Async rule |
| Update loop, pooling, allocation, draw call, or mobile risk | Performance Reviewer |
| Input behavior, feedback, animation, sound, haptics, or clarity | Game Feel Reviewer |
| Rule-driven environment or simulation | State/action/reward/termination skills |
| Medium or large task | Runtime artifacts and validation report |

---

## What This Is Not

- not a Unity plugin
- not a Unity Package Manager package
- not a full game framework
- not a one-click game generator
- not a replacement for Unity engineering judgment

---

## License

MIT License
