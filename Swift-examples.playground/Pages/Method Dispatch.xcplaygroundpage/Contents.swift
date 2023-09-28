import Foundation

/// Method Dispatch heppens always when a method is called
/// It is a process during which the program chooses which instructions to run
/// It looks like this  `Method call -> Method Dispatch -> Method Processing`
/// Method Dispatch tells CPU where to find in memory the instructions of the method
/// There are three types of Method Dispatch
/// 1) ``Direct Dispatch``
/// 2) ``Table Dispatch``
///     2.a) `Virtual`
///     3.a) `Witness`
/// 3) ``Message Dispatch``



// MARK: - Direct Dispatch      aka Static Dispatch
/// The fastest way to send the method
/// OOP is limited
/// `Value types` use ``Direct Dispatch``

/// Example 1 - Final Class
/// `final` forbids `inheritance`
/// and methods cannot be `override`d
/// and ``Direct Dispatch`` is used
///
final class ClassExample1 {
    
    /// ``Direct Dispatch``
    func doSomething() {
        print("Example 1 - Final Class")
    }
    
}



// MARK: Example 2 - Protocol Extension
/// Default implementation of a method
/// Changes Dispatch from `Witnes` to `Direct`
///
protocol SomeProtocol {
    func doSomething()
}

extension SomeProtocol {
    
    /// ``Direct Dispatch``
    func doSomething() {
        print("Example 2 - Protocol Extension")
    }
    
}

class ClassExample2: SomeProtocol {}

let classExample2 = ClassExample2()
classExample2.doSomething()



// MARK: Example 3 - Class Extension
/// methods in extension cannot be `override`d
/// and it uses ``Direct Dispatch``
class ClassExample3 {}

extension ClassExample3 {
    
    /// ``Direct Dispatch``
    func doSomething() {
        print("Example 3 - Class Extension")
    }
    
}

let classExample3 = ClassExample3()
classExample3.doSomething()



// MARK: Example 4 - Access Control
/// `private` methods can not be `override`d
/// so it uses ``Direct Dispatch``
class ClassExample4 {
    
    func doSomething() {
        doSomethingPrivate()
    }
    
    /// ``Direct Dispatch``
    private func doSomethingPrivate() {
        print("Example 4 - Access Control")
    }
}





// MARK: - Virtual Dispatch











