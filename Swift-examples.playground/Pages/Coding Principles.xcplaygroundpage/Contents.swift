import Foundation


// MARK: - YAGNI: You Are Not Gonna Need It
/// Do not write the code - if you think it will be needed later

/// Especiallt during refactoring
/// Delete those codes, that are no longer needed. Even if they were used in the past.
/// If it will be need in the future, you can get from the git




// MARK: - DRY: Don't Repeat Yourself
/// Duplicating a code - is waste of time and resource. You have to keep up to date code in several places at once
/// Duplication happens because of the lack of the knowledge about the system.
/// Before coding, it is better to research the system. May be the functionality is already implemented

/// This conept was described in the book "Программист-прагматик: путь от подмастерья к мастеру" by Andy Hunt and Dave Thomas
/// It is about the `Single Source of Truth` (SSOT):
/// In information systems design and theory, a single source of truth (SSOT) is the practice of structuring information models and data schema,
/// which implies that all pieces of data are processed (or edited) in only one place... SSOTs provide reliable, relevant and usable data




// MARK: - KISS: Keep It Simple, Stupid
/// This principle states that simple systems are sfare and more reliable
/// Do not reinvent the wheel. Do not use new tool because they are new, but because they are appropriate




// MARK: - Big Design UP Front
/// Before starting implementation, make sure that everything is clear
/// Some coders might think that if you do not write code then you are not coder. It is better to think as Developer
/// Without planning, starting fromo scratch is about to happen several times
/// Early problem detection is better than adhoc solutions

/// A very common counter-argument is that the cost of solving problems is often less than the cost of planning time.
/// The fewer errors a user encounters, the better their experience will be. You may not have another chance to deal with these mistakes.




// MARK: SOLID
/// **Single Responsibility**
/// Its importance cannot be overstated. Each object, class and method should be responsible for only one thing. If your object/class/method does too much, you'll end up with spaghetti code.
/// Another side effect of such code is problems with testing. Convoluted functionality is difficult to test.

/// **Open - Close**
/// Software objects must be open for extension, but closed for modification. The point is that you cannot override methods or classes, simply adding additional functions as needed.
/// A good way to solve this problem is to use inheritance. JavaScript solves this problem using composition.
/// A simple rule: if you change an entity to make it extensible, you have violated this principle for the first time.

/// **Liskov Substitution**
/// This principle states that objects of higher classes should be replaceable with objects of subclasses, and the application should perform as expected when replaced.

/// **Interface Segregation**
/// Objects should not depend on interfaces that they do not use
/// The software must be divided into independent parts. Side effects should be kept to a minimum to ensure independence.
/// Make sure you don't force objects to implement methods they will never need.

/// **Dependency Inversion**
/// This principle cannot be overemphasized. We must rely on abstractions rather than concrete implementations. Software components should have low coupling and high consistency.
/// You need to care not about how something works, but about how it works. A simple example is using dates in JavaScript. You can write your own abstraction layer for them.
/// Then if your source for receiving dates changes, you will need to make changes in one place, and not in a thousand.
/// Sometimes adding this level of abstraction takes effort, but it pays off in the long run.




// MARK: Avoid Premature Optimization
/// This practice encourages developers to optimize code before the need for optimization has been proven. I think if you follow KISS or YAGNI you won't get hooked.
/// Don't get me wrong, anticipating something bad will happen is a good thing. But before you dive into implementation details, make sure these optimizations are actually useful.
/// A very simple example is scaling. You wouldn't buy 40 servers on the assumption that your new application will become very popular. You will add servers as needed.
/// Premature optimization can cause delays in the code and therefore increase the time it takes to get features to market.
/// Many people consider premature optimization to be the root of all evil.




// MARK: Razor Occam
/// Don't create unnecessary entities unnecessarily. Be pragmatic - consider whether they are necessary as they may end up adding complexity to your codebase





//MARK: - Summary
/// These principles are not very complicated. In fact, it is their simplicity that makes them beautiful.
/// If you're confused, don't try all of them at once. Just try to work consciously and try to gradually incorporate these principles into your work process.

/// Using basic but powerful principles will allow you to become a better programmer and have a clearer understanding of why you do things.

/// If you apply most of the principles intuitively, it's worth thinking about and being aware of why you do things a certain way.
