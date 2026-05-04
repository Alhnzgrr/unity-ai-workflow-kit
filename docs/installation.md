# Installation

## Install Into A Unity Project

Run from this repository:

```powershell
.\scripts\install-unity-project.ps1 -ProjectPath "C:\Path\To\UnityProject"
```

This creates or updates:

```text
UnityProject/Assets/unity-ai-workflow-kit/
```

## Install Codex Adapter

Run from this repository:

```powershell
.\scripts\install-codex-adapter.ps1
```

This creates or updates:

```text
%USERPROFILE%\.codex\skills\unity-ai-workflow-kit\
```

## Validate Install

Run:

```powershell
.\scripts\validate-install.ps1 -ProjectPath "C:\Path\To\UnityProject"
```

## Install Claude Adapter

Run:

```powershell
.\scripts\install-claude-adapter.ps1 -ProjectPath "C:\Path\To\UnityProject"
```

This creates or updates:

```text
UnityProject/CLAUDE.md
UnityProject/.claude/commands/
```

## Install Cursor Adapter

Run:

```powershell
.\scripts\install-cursor-adapter.ps1 -ProjectPath "C:\Path\To\UnityProject"
```

This creates or updates:

```text
UnityProject/.cursor/rules/
```
