# Architecture

Unity AI Workflow Kit is a source repository that installs project-local workflow artifacts.

## Source Of Truth

The canonical workflow content lives in `kit/`.

`kit/` is tool-agnostic. It should not contain Codex, Claude, or Cursor-specific assumptions unless those assumptions apply to all AI tools.

## Installed Unity Artifact

Unity projects receive a copy of the kit at:

```text
Assets/unity-ai-workflow-kit/
```

That installed copy is where project-local runtime artifacts are written.

## AI Tool Adapters

Adapters live in `adapters/`.

Each adapter should stay thin. Its job is to teach a specific AI tool how to find and use the installed Unity kit, not to duplicate the entire workflow system.

## Runtime Artifacts

Runtime artifacts belong to the Unity project, not this source repository.

Use `kit/runtime-template/` only to preserve the empty folder structure installed into projects.
