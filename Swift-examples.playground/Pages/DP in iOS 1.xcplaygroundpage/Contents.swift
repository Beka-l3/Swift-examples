import Foundation


/// Design patterns are reusable solutions to common problems in software design.
/// They’re templates designed to help you write code that’s easy to understand and reuse. Most common Cocoa design patterns:
/// **Creational**: Singleton.
/// **Structural**: Decorator, Adapter & Facade.
/// **Behavioral**: Observer and Memento


// MARK: - Facade
/// The Facade design pattern provides a single/simpler interface to a complex subsystem.
/// Instead of exposing the user to a set of classes and their APIs, you only expose one simple unified API.

/// This pattern is ideal when working with a large number of classes, particularly when they are complicated to use or difficult to understand.
/// This is also useful if the classes under the facade are likely to change, as the facade class can retain the same API while things change behind the scenes.
/// For example, if the day comes when you want to replace your backend service, you won’t have to change the code that uses your API, just the code inside your Facade




// MARK: - Decorator
/// The Decorator pattern dynamically adds behaviors and responsibilities to an object without modifying its code.
/// It’s an alternative to subclassing where you modify a class’s behavior by wrapping it with another object

/// In Objective-C there are two very common implementations of this pattern: `Category` and `Delegation`.
/// In Swift there are also two very common implementations of this pattern: `Extensions` and `Delegation`

/// Delegate: This is used to keep implementation specific behavior out of the generic class.
/// Many UI elements in iOS use delegates to control their behaviour e.g. UIScrollView.
/// The UIScrollView class has no knowledge of what it should be scrolling as that is an application specific task.
/// So to notify the application of scrolling events, it uses the UIScrollViewDelegate.
/// The application can implement the delegate and then intercept the scrolling events sent to it by the UIScrollView.




// MARK: - Memento
/// In Memento Pattern saves your stuff somewhere.
/// Later on, this externalized state can be restored without violating encapsulation;
/// that is, private data remains private. Implementations example of the Memento pattern is Archiving, Serialization and State Restoration.




// MARK: - Adapter
/// The Adapter design pattern converts the interface of a class into another interface that clients expect.
/// Adapter lets classes work together that couldn’t otherwise because of incompatible interfaces.
/// It decouples the client from the class of the targeted object. Apple uses protocols to do the job.
/// You may be familiar with protocols like UITableViewDelegate, UIScrollViewDelegate, NSCoding and NSCopying.
/// As an example, with the NSCopying protocol, any class can provide a standard copy method




// MARK: - Observer
/// The Observer design pattern defines a one-to-many dependency between objects so that when one object changes state, all its dependents are notified and updated automatically.
/// The Observer pattern is essentially a publish-and-subscribe model in which the subject and its observers are loosely coupled.
/// Communication can take place between the observing and observed objects without either needing to know much about the other.
/// Cocoa implements the observer pattern in two ways: `Notifications` and `Key-Value Observing` (KVO).




// MARK: - Strategy
/// Strategy pattern allows you to change the behaviour of an algorithm at run time.
/// Using interfaces, we are able to define a family of algorithms, encapsulate each one, and make them interchangeable, allowing us to select which algorithm to execute at run time.
/// For more information check these two out by Thomas Hanning and Sam Stone.




// MARK: - Factory
/// Factory method pattern makes the codebase more flexible to add or remove new types.
/// To add a new type, we just need a new class for the type and a new factory to produce it like the following code. For more information check this out.




// MARK: - Command
/// The Command design pattern encapsulates a request as an object,
/// thereby letting you parameterize clients with different requests, queue or log requests, and support undoable operations.
/// The request object binds together one or more actions on a specific receiver.
/// The Command pattern separates an object making a request from the objects that receive and execute that request. E.g. Target action mechanism.




// MARK: - Composite
/// The Composite design pattern composes related objects into tree structures to represent part-whole hierarchies.
/// It lets clients treat individual objects and compositions of objects uniformly. It is part of the Model-View-Controller aggregate pattern. E.g. View Hierarchy




// MARK: - Iterator
/// The Iterator design pattern provides a way to access the elements of an aggregate object (that is, a collection) sequentially without exposing its underlying representation.
/// The Iterator pattern transfers the responsibility for accessing and traversing the elements of a collection from the collection itself to an iterator object.
/// The Iterator defines an interface for accessing collection elements and keeps track of the current element. Different iterators can carry out different traversal policies. E.g. Enumerators




// MARK: - Mediator
/// The Mediator design pattern defines an object that encapsulates how a set of objects interact.
/// Mediator promotes loose coupling by keeping objects from referring to each other explicitly, and it lets you vary their interaction independently.
/// These objects can thus remain more reusable. A “mediator object” in this pattern centralizes complex communication and control logic between objects in a system.
/// These objects tell the mediator object when their state changes and, in turn, respond to requests from the mediator object. E.g. Controller Classes in the AppKit Framework & View Controllers in UIKit




// MARK: - Singleton
/// The Singleton design pattern ensures a class only has one instance, and provides a global point of access to it.
/// The class keeps track of its sole instance and ensures that no other instance can be created.
/// Singleton classes are appropriate for situations where it makes sense for a single object to provide access to a global resource.
/// It usually uses lazy loading to create the single instance when it’s needed the first time.

