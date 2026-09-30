# Unity AI Workflow Kit

Build Unity projects with AI without losing architectural control.

AI writes Unity C# quickly. Left alone it also writes 400-line MonoBehaviours,
reaches for singletons, edits `.prefab` files as text, and adds a null check
rather than fixing the wiring that made the reference null. None of that is a
model being careless — it is what happens when nothing says no.

This kit is the part that says no: engineering rules, review gates, and hooks
that refuse an edit outright.

```powershell
git clone https://github.com/Alhnzgrr/unity-ai-workflow-kit.git
cd unity-ai-workflow-kit

.\scripts\install-unity-project.ps1   -ProjectPath "C:\Path\To\YourUnityProject"
.\scripts\install-claude-adapter.ps1  -ProjectPath "C:\Path\To\YourUnityProject"
.\scripts\validate-install.ps1        -ProjectPath "C:\Path\To\YourUnityProject"
```

Adapters for [Codex](adapters/codex) and [Cursor](adapters/cursor) install the
same way. Then open an AI session in the project and start with:

> Use `Assets/unity-ai-workflow-kit/AGENTS.md` as the primary workflow guide.
> Load only the agent, rule and skill files this task needs — not the whole kit.
>
> Task: *[describe the Unity task]*

---

## The three layers

**Rules** state the decisions once, in [`kit/rules/`](kit/rules): composition
through DI rather than singletons, async through UniTask with lifetime-bound
cancellation, ScriptableObjects for tunable values, thin MonoBehaviours over
plain C# services, no defensive null-fallback on dependencies guaranteed by
construction. The model reads them as constraints; a human reads them as
documentation of how the project is built.

**Hooks** enforce what rules only assert. Five scripts in
[`kit/hooks/`](kit/hooks) run on every `Write` and `Edit` and exit non-zero to
refuse the edit:

| Hook | Behaviour |
| --- | --- |
| `block-serialized-unity-edit` | **Blocks** text edits to `.unity`, `.prefab` and authored `.asset` files |
| `guard-editor-runtime` | **Blocks** `UnityEditor` in runtime code without a `UNITY_EDITOR` guard |
| `check-core-boundary` | **Blocks** `UnityEngine`, `MonoBehaviour` and input types inside `Core/` and `Environment/` |
| `check-input-boundary` | **Blocks** the legacy `Input` API; **warns** on action maps enabled but never disabled |
| `warn-serialized-rename` | **Warns** when a `[SerializeField]` name changes without `[FormerlySerializedAs]` |

The first one matters most. Unity's serialized files are YAML full of fileIDs
and GUIDs, and a text edit that looks correct can break a reference that only
surfaces later, somewhere else, as a missing script. With this hook installed,
every scene and prefab change goes through a person in the Editor — which also
means the division of labour in the repository is a fact rather than a claim.

Each hook ships as PowerShell (`.ps1`, installed by default) and as bash
(`.sh`, for macOS and Linux — those need `jq`).

**Agents** split the work. [`kit/agents/`](kit/agents) holds seven, but the
useful property is that implementation and review never share a context:
`code-reviewer` and `performance-reviewer` get read-only tools and audit the
change against the rules afterwards. The model that just wrote the code is the
worst available judge of it.

---

## What gets installed where

```
YourUnityProject/
  CLAUDE.md                          project instructions
  .claude/
    settings.json                    wires the hooks onto Write and Edit
    hooks/       *.ps1               the five guardrails
    agents/      *.md                reviewers and implementers
    commands/    *.md                slash commands
  Assets/unity-ai-workflow-kit/      the reference content, versioned with the project
    AGENTS.md  agents/  commands/  hooks/  rules/  skills/  templates/  workflows/
    runtime/    tasks/  handoffs/  reviews/  validations/  logs/
```

The split is deliberate. `.claude/` is what the tool reads and executes;
`Assets/unity-ai-workflow-kit/` is reference material that belongs to the Unity
project and travels with it in version control.

`install-claude-adapter.ps1` is safe to re-run: it replaces kit-owned hook
entries instead of appending duplicates, and backs up any existing
`settings.json` before merging. `validate-install.ps1` then checks the thing
worth checking — that every hook command in `settings.json` resolves to a file
that exists. A path typo there fails silently, and an unguarded tool call looks
exactly like a guarded one that allowed the edit.

---

## Which gate applies

| Trigger | Gate |
| --- | --- |
| New or unclear feature | `unity-architect` |
| Scene, prefab, ScriptableObject or inspector wiring | `unity-setup` |
| Serialized field, prefab, scene or asset change | serialization rule |
| MonoBehaviour lifecycle or scene-facing code | unity-runtime rule |
| Dependency wiring or service composition | dependency-injection rule |
| Async, timer, delay, cancellation, sequencing | async rule |
| Update loop, pooling, allocation, draw calls, mobile | `performance-reviewer` |
| Input feel, feedback, animation, sound, haptics | `game-feel-reviewer` |
| Medium or large task | runtime artifacts and a validation report |

Artifacts for a task land in the project, not in this repository:

```
Assets/unity-ai-workflow-kit/runtime/tasks/2026-09-30-inventory-ui.task.md
Assets/unity-ai-workflow-kit/runtime/handoffs/2026-09-30-inventory-ui.architecture.md
Assets/unity-ai-workflow-kit/runtime/reviews/2026-09-30-inventory-ui.code-review.md
Assets/unity-ai-workflow-kit/runtime/validations/2026-09-30-inventory-ui.validation.md
```

---

## Seen working

[**Stack Attack**](https://github.com/Alhnzgrr/stack-attack) — a Unity 6 arcade
shooter built under a project-local version of this workflow, with the `.claude/`
setup committed alongside the game. Its
[How This Was Built](https://github.com/Alhnzgrr/stack-attack#how-this-was-built)
section is the same idea applied to one project.

---

## What this is not

Not a Unity Package Manager package, not a plugin, not a game framework, and not
a one-click generator. It does not replace Unity engineering judgment — it is a
way of holding on to it while a model does the typing.

MIT licensed.
