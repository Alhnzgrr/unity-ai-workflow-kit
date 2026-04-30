# Unity AI Workflow Kit — AGENTS.md

## Overview
This file defines the agent roles and coordination flow for AI-assisted Unity development.
Use this file as the primary context for your AI assistant.

---

## Agent Roster

| Agent | File | Responsibility |
|---|---|---|
| Unity Architect | agents/unity-architect.md | System design, class boundaries, data flow |
| Gameplay Programmer | agents/gameplay-programmer.md | Feature implementation |
| Code Reviewer | agents/code-reviewer.md | Code quality, architecture, correctness |
| Performance Reviewer | agents/performance-reviewer.md | Allocations, draw calls, mobile performance |
| Game Feel Reviewer | agents/game-feel-reviewer.md | Feedback, timing, player experience |

---

## When To Use Which Agent

### Starting a new feature
→ Start with **Unity Architect**  
Use when: You have an idea but no technical plan yet.  
Ask for: System design, class list, data flow, risks.

### Implementing a designed feature
→ Use **Gameplay Programmer**  
Use when: You have a technical plan and need working code.  
Ask for: Implementation, tuning values, feedback hooks.

### Reviewing existing or generated code
→ Use **Code Reviewer**  
Use when: Code is written and needs quality check.  
Ask for: Correctness, architecture, lifecycle safety.

### Reviewing for mobile performance
→ Use **Performance Reviewer**  
Use when: Feature is implemented and you want to check mobile impact.  
Ask for: Allocation check, draw call audit, mobile-specific risks.

### Reviewing for player experience
→ Use **Game Feel Reviewer**  
Use when: Feature works and you want to evaluate how it feels.  
Ask for: Feedback gaps, timing issues, haptic and audio opportunities.

---

## Standard Feature Flow

Use this flow for any non-trivial feature:

DESIGN  
Agent: Unity Architect  
Input: Feature description in plain language  
Output: Class list, responsibilities, data flow, risks  

IMPLEMENT  
Agent: Gameplay Programmer  
Input: Architect output + feature description  
Output: Working code, Unity setup steps, tuning values  

REVIEW  
Agent: Code Reviewer  
Input: Implemented code  
Output: Must Fix / Should Improve / Optional  

PERFORMANCE CHECK  
Agent: Performance Reviewer  
Input: Reviewed code  
Output: Critical issues / Watch list / Mobile checklist  

FEEL CHECK  
Agent: Game Feel Reviewer  
Input: Working feature in context  
Output: Missing feedback / Polish opportunities  

---

## Quick Flow (Small Features)

For small, low-risk features skip Design and go directly to implementation:

IMPLEMENT  
Agent: Gameplay Programmer  

REVIEW  
Agent: Code Reviewer  

FEEL CHECK  
Agent: Game Feel Reviewer  

Use Quick Flow when:
- The feature touches only one system  
- No new classes are needed  
- Risk of architectural impact is low  

---

## Refactor Flow

Use when improving existing code without adding new behavior:

REVIEW  
Agent: Code Reviewer  
Goal: Identify what needs to change and why  

DESIGN (if structural changes needed)  
Agent: Unity Architect  
Goal: Plan the refactored structure  

IMPLEMENT  
Agent: Gameplay Programmer  
Goal: Apply the refactor cleanly  

---

## Example Prompts

### Starting a feature
Use agents/unity-architect.md.  
Act as Unity Architect.  
Design the system for this feature:  
[describe your feature here]

### Implementing a feature
Use agents/gameplay-programmer.md.  
Act as Gameplay Programmer.  
Here is the technical plan:  
[paste architect output]  
Implement this feature.

### Reviewing code
Use agents/code-reviewer.md.  
Act as Code Reviewer.  
Review this code:  
[paste code]

### Full pipeline prompt
Use agents/unity-architect.md, agents/gameplay-programmer.md, agents/code-reviewer.md.  
Step 1: Act as Unity Architect. Design this feature: [description]  
Step 2: Act as Gameplay Programmer. Implement the design from Step 1.  
Step 3: Act as Code Reviewer. Review the code from Step 2.  

---

## Agent Combination Rules

| Situation | Agents to combine |
|---|---|
| Mobile-critical system | Performance Reviewer + Game Feel Reviewer |
| Core gameplay mechanic | Architect + Gameplay Programmer + Game Feel Reviewer |
| Legacy code cleanup | Code Reviewer + Architect |

---

## Context Management

AI tools have limited context windows.  
Load only what you need per session:

- For design sessions: `AGENTS.md` + `agents/unity-architect.md` + relevant skill  
- For implementation: `AGENTS.md` + `agents/gameplay-programmer.md` + relevant skill  
- For review: `AGENTS.md` + `agents/code-reviewer.md`  
- For full pipeline: Load agents one at a time per step  

Do not load all agents and all skills at once.  
This reduces response quality.

---

## Skills Reference

| Feature Type | Recommended Skills |
|---|---|
| New system | skills/unity-clean-architecture/SKILL.md |
| Gameplay mechanic | skills/game-feel/SKILL.md + skills/state-machine/SKILL.md |
| Object management | skills/object-pooling/SKILL.md |
| Dependency management | skills/dependency-injection/SKILL.md |
| Mobile feature | skills/mobile-development/SKILL.md |
| Hybrid casual mechanic | skills/hybrid-casual/SKILL.md |
