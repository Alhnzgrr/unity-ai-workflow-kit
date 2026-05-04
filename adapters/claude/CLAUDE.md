# Unity AI Workflow Kit Adapter for Claude Code

When this adapter is installed in a Unity project, use `Assets/unity-ai-workflow-kit/AGENTS.md` as the primary workflow entrypoint.

Load only the agent, rules, and skills required by the current task. Do not load every file in the kit at once.

Use project-local artifacts in `Assets/unity-ai-workflow-kit/runtime/` for tasks, handoffs, reviews, validations, and logs.
