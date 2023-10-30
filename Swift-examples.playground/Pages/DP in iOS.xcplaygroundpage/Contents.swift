import Foundation


/// Design patterns are reusable solutions to common problems in software design.
/// They’re templates designed to help you write code that’s easy to understand and reuse. Most common Cocoa design patterns:
/// **Creational**: Singleton.
/// **Structural**: Decorator, Adapter & Facade.
/// **Behavioral**: Observer and Memento


// MARK: - Facade
/// The Facade design pattern provides a single interface to a complex subsystem.
/// Instead of exposing the user to a set of classes and their APIs, you only expose one simple unified API.

/// This pattern is ideal when working with a large number of classes, particularly when they are complicated to use or difficult to understand.
/// This is also useful if the classes under the facade are likely to change, as the facade class can retain the same API while things change behind the scenes.
/// For example, if the day comes when you want to replace your backend service, you won’t have to change the code that uses your API, just the code inside your Facade




// MARK: - Decorator
/// The Decorator pattern dynamically adds behaviors and responsibilities to an object without modifying its code. It’s an alternative to subclassing where you modify a class’s behavior by wrapping it with another object

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






