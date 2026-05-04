# Technical Design Document

## 1. Technical Overview

Describe the implementation approach.

## 2. Unity Version / Target Platform

```text
Unity Version:
Render Pipeline:
Target Platform:
Orientation:
Input System:
```

## 3. Architecture

Recommended structure:

```text
Core/
Systems/
Views/
Data/
UI/
Installers/
Tests/
```

Explain which layers will be used.

## 4. Main Systems

For each system:

```text
System Name:
Responsibility:
Dependencies:
Input:
Output:
Unity Coupling:
Testability:
```

## 5. Core Models

List pure C# models and data structures.

```text
Model:
Fields:
Purpose:
Rules:
```

## 6. MonoBehaviour Views

List Unity-facing behaviours.

```text
View:
Scene Role:
Serialized References:
Events Sent:
Events Received:
```

## 7. Data / Config

List ScriptableObjects or config classes.

```text
Config:
Fields:
Used By:
Designer Tunable:
```

## 8. Dependency Injection

If DI is used:

```text
DI Framework:
Installers:
Bindings:
Lifetime:
```

If DI is not used, describe how dependencies are created and passed.

## 9. Performance Considerations

Check:

- allocations
- Update loops
- pooling
- physics
- UI rebuilds
- draw calls
- mobile constraints

## 10. Save / Persistence

Describe what needs to be saved.

```text
Data:
Format:
Versioning:
Migration:
```

## 11. Testing Plan

List testable systems.

```text
EditMode Tests:
PlayMode Tests:
Manual Tests:
```

## 12. Risks and Trade-Offs

List known implementation risks.

## 13. Implementation Phases

Break the work into phases:

```text
Phase 1:
Goal:
Tasks:
Validation:

Phase 2:
Goal:
Tasks:
Validation:
```
