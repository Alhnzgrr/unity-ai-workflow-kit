# Dependency Injection Skill

## Purpose
Help AI assistants apply dependency injection in Unity projects
in a practical way that improves testability and reduces hidden coupling
without overcomplicating small or mid-size projects.

## Core Idea
Dependency injection means a class receives what it needs
instead of creating or finding it itself.

This makes dependencies explicit, systems testable,
and the codebase easier to change.

## The Problem DI Solves

```csharp
// Bad — hidden dependency
public class PlayerMovementSystem
{
    private InputService _input;

    public PlayerMovementSystem()
    {
        _input = ServiceLocator.Get<InputService>(); // hidden, hard to test
    }
}

// Good — explicit dependency
public class PlayerMovementSystem
{
    private readonly IInputService _input;

    public PlayerMovementSystem(IInputService input)
    {
        _input = input;
    }
}
```

The second version is testable, explicit, and decoupled.

## When To Use DI
Use when:
- A system has dependencies that should be swappable or mockable
- You want to test systems without a Unity scene
- The project has multiple systems that share services
- The codebase is growing and hidden dependencies are becoming a problem

Do not use when:
- The project is a small prototype with 2-3 systems
- The added structure costs more than it saves
- The team is not familiar with DI and the deadline is tight

## Constructor Injection (Preferred)
Inject dependencies through the constructor for plain C# systems:

```csharp
public class ScoreSystem
{
    private readonly IScoreRepository _repository;
    private readonly IEventBus _eventBus;

    public ScoreSystem(IScoreRepository repository, IEventBus eventBus)
    {
        _repository = repository;
        _eventBus = eventBus;
    }

    public void AddScore(int amount)
    {
        _repository.Add(amount);
        _eventBus.Publish(new ScoreChangedEvent(amount));
    }
}
```

## Method Injection
Use when only one method needs the dependency:

```csharp
public void Initialize(IInputService input)
{
    _input = input;
}
```

## Zenject (VContainer Alternative)
If using a DI framework, prefer VContainer over Zenject for new projects.
VContainer is faster, lighter, and has cleaner syntax.

### VContainer Example

```csharp
// Installer
public class GameLifetimeScope : LifetimeScope
{
    protected override void Configure(IContainerBuilder builder)
    {
        builder.Register<InputService>(Lifetime.Singleton);
        builder.Register<ScoreSystem>(Lifetime.Singleton);
        builder.RegisterComponentInHierarchy<PlayerView>();
    }
}

// Consumer
public class ScoreSystem
{
    private readonly InputService _input;

    public ScoreSystem(InputService input)
    {
        _input = input;
    }
}
```

### Zenject Example (if already in project)

```csharp
// Installer
public class GameInstaller : MonoInstaller
{
    public override void InstallBindings()
    {
        Container.Bind<IInputService>().To<InputService>().AsSingle();
        Container.Bind<ScoreSystem>().AsSingle();
    }
}

// Consumer
public class ScoreSystem
{
    [Inject]
    public ScoreSystem(IInputService input)
    {
        _input = input;
    }
}
```

## Without a Framework
DI does not require a framework.
Manual DI works well for small and mid-size projects:

```csharp
// Composition root — wire everything here
public class GameInstaller : MonoBehaviour
{
    [SerializeField] private PlayerView _playerView;

    private void Awake()
    {
        var inputService = new InputService();
        var scoreSystem = new ScoreSystem(new ScoreRepository(), new EventBus());
        var playerSystem = new PlayerMovementSystem(inputService);

        _playerView.Initialize(playerSystem);
    }
}
```

This approach is transparent, easy to understand, and requires no framework knowledge.

## Interface Guidelines
Do not create an interface for every class.
Create interfaces when:
- The dependency needs to be swapped (real vs mock in tests)
- The boundary between systems is meaningful
- Multiple implementations are realistic

```csharp
// Justified interface — testable, swappable
public interface IScoreRepository
{
    void Add(int amount);
    int GetTotal();
}

// Unjustified interface — only one implementation will ever exist
public interface IPlayerMovementSystem { ... } // skip this
```

## Rules
- Prefer constructor injection for plain C# classes
- Prefer [SerializeField] injection for MonoBehaviours (Unity-idiomatic)
- Keep installers focused — one installer per feature or scope
- Do not inject the container itself into systems
- Do not use static service locators as a DI substitute
- Dependencies should flow inward: Views depend on Systems, Systems depend on Core

## Mobile Considerations
- Avoid heavy DI framework initialization on the main thread at startup
- Use scoped lifetimes to avoid holding references longer than needed
- Dispose systems explicitly when a scene or feature is unloaded

## Common Mistakes
- Creating interfaces for everything without a real reason
- Injecting too many dependencies into one class (signals it needs splitting)
- Using DI framework but still accessing globals via singletons
- Binding everything as singleton when scoped lifetime is more appropriate
- Adding a DI framework to a project that does not need one

## AI Review Guidance
When reviewing DI usage, check:
- Are dependencies injected, not created or found internally?
- Are interfaces used only where they add real value?
- Is the composition root clear and easy to follow?
- Are there hidden dependencies still using FindObjectOfType or singletons?
- Is the DI framework adding value or just complexity?