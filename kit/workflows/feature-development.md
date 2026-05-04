# Feature Development Workflow

Use this workflow when adding a new feature to a Unity project with AI assistance.

## Goal

Develop features in a controlled way without losing architecture, readability, or gameplay quality.

## Step 1 — Feature Brief

Start with a small feature brief.

```text
Feature:
Player Action:
Expected Result:
Success Condition:
Failure Condition:
Platform:
Constraints:
```

## Step 2 — Architecture Pass

Ask the Unity Architect agent to define:

- required classes
- responsibilities
- data flow
- Unity scene requirements
- risks
- validation steps

Do not write code yet.

## Step 3 — Implementation Plan

Break the feature into small tasks.

Example:

```text
Task 1: Create core model
Task 2: Create gameplay system
Task 3: Create MonoBehaviour view
Task 4: Connect input
Task 5: Add feedback
Task 6: Add validation
```

## Step 4 — Code Implementation

Ask the Gameplay Programmer agent to implement only the current task.

Rules:

- keep changes scoped
- do not rewrite unrelated systems
- explain assumptions
- mention Unity setup steps
- expose tuning values where useful

## Step 5 — Game Feel Pass

Ask the Game Feel Reviewer to check:

- input response
- impact
- feedback
- animation
- sound
- VFX
- haptics
- UI clarity

Add feedback hooks even if final assets are not ready.

## Step 6 — Code Review

Ask the Code Reviewer to review the change.

Required review sections:

```text
Must Fix:
Should Improve:
Optional:
Game Feel Notes:
Validation:
```

## Step 7 — Manual Validation

Run the feature in Unity.

Check:

- Does it compile?
- Does it work in the scene?
- Is the input responsive?
- Does the feature feel clear?
- Are there console errors?
- Does it behave correctly after scene reload?
- Does it break existing systems?

## Step 8 — Refactor If Needed

Refactor only if there is a clear issue.

Good reasons:

- class has too many responsibilities
- logic is not testable
- MonoBehaviour is too large
- performance risk is obvious
- feature will be extended soon

Bad reasons:

- pattern for pattern's sake
- premature abstraction
- unnecessary interfaces
- making the feature harder to understand

## Step 9 — Document

Update relevant docs:

- GDD if the design changed
- TDD if architecture changed
- feature notes if setup is required
- code review checklist if new risks were discovered
