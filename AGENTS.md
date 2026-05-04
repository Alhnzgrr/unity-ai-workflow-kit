# Unity AI Workflow Kit Repository

## Repository Role

This repository is the source of truth for Unity AI Workflow Kit.

It is not a Unity Package Manager package. It generates or installs a project-local workflow kit into a Unity project, and can also install thin adapters for AI tools such as Codex, Claude Code, and Cursor.

## Source Layout

```text
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

dist/
docs/
```

## Editing Rules

- Treat `kit/` as the canonical project-local workflow kit source.
- Treat `adapters/` as AI-tool-specific integration layers.
- Treat `scripts/` as installation and validation automation.
- Do not store real project runtime artifacts in this repository.
- Use `kit/runtime-template/` only for empty runtime folder structure.
- Installed Unity project artifacts should live in `Assets/unity-ai-workflow-kit`.

## Installed Artifact Model

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

Use the scripts in `scripts/` to install or validate these artifacts.
