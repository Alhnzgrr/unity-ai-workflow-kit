# Unity AI Workflow Kit

Build Unity projects with AI without losing architectural control.

![License](https://img.shields.io/badge/license-MIT-blue)
![Unity](https://img.shields.io/badge/Unity-Workflow-black)
![AI](https://img.shields.io/badge/AI-Assisted-purple)

---

## Quick Start

Clone this repository:

```powershell
git clone https://github.com/Alhnzgrr/unity-ai-workflow-kit.git
cd unity-ai-workflow-kit
```

Install the kit into your Unity project:

```powershell
.\scripts\install-unity-project.ps1 -ProjectPath "C:\Path\To\YourUnityProject"
```

Validate the install:

```powershell
.\scripts\validate-install.ps1 -ProjectPath "C:\Path\To\YourUnityProject"
```

Then install the adapter for your AI tool.

Codex:

```powershell
.\scripts\install-codex-adapter.ps1
```

Claude Code:

```powershell
.\scripts\install-claude-adapter.ps1 -ProjectPath "C:\Path\To\YourUnityProject"
```

Cursor:

```powershell
.\scripts\install-cursor-adapter.ps1 -ProjectPath "C:\Path\To\YourUnityProject"
```

Start your AI session with:

```text
Use Assets/unity-ai-workflow-kit/AGENTS.md as the primary workflow guide.

For this task, load only the required agent, rule, and skill files. Do not load the entire kit at once.

Task:
[describe the Unity task]
```

---

## What Is This?

**Unity AI Workflow Kit** is a source repository for installing a project-local AI workflow system into Unity projects.

It gives AI tools a structured way to work through:

- agent roles
- workflow commands
- engineering rules
- reusable skills
- handoff templates
- review and validation gates
- project-local runtime artifacts
- optional adapters for Codex, Claude Code, and Cursor

This is not a Unity Package Manager package. Install it with the scripts in this repository.

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

## How It Works

The repository is the source of truth:

```text
unity-ai-workflow-kit/
```

The installer copies the workflow kit into your Unity project:

```text
UnityProject/Assets/unity-ai-workflow-kit/
```

AI tool adapters are installed separately:

```text
.codex/
.claude/
.cursor/
```

The source repository stores reusable kit content. Your Unity project stores project-specific tasks, handoffs, reviews, validations, and logs.

---

## Installed Kit Contents

After installation, your Unity project receives:

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

Use `Assets/unity-ai-workflow-kit/AGENTS.md` as the entrypoint for AI work.

---

## Pick The Right Flow

Use these gates to avoid skipping important workflow phases:

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

`kit/` is tool-agnostic workflow content.

`adapters/` contains thin AI-tool-specific integration files.

`scripts/` contains install and validation automation.

`dist/` is reserved for generated output.

`docs/` contains architecture and installation notes.

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
