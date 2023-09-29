import Foundation

/// Method Dispatch heppens always when a method is called
/// It is a process during which the program chooses which instructions to run
/// It looks like this  `Method call -> Method Dispatch -> Method Processing`
/// Method Dispatch tells CPU where to find in memory the instructions of the <link to>  method
/// There are three types of Method Dispatch
/// 1) ``Direct Dispatch``
/// 2) ``Table Dispatch``
///     2.a) `Virtual`
///     3.a) `Witness`
/// 3) ``Message Dispatch``



// MARK: - Direct Dispatch      aka Static Dispatch
/// `The fastest way to send the method` - ``advantade``
/// `OOP is limited` - **disadvantage**
///     `No polymophism` - **disadvantage**

/// `Value types` use ``Direct Dispatch``



// MARK: Example 1 - Final Class
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
///
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
///
class ClassExample4 {
    
    func doSomething() {
        doSomethingPrivate()
    }
    
    /// ``Direct Dispatch``
    private func doSomethingPrivate() {
        print("Example 4 - Access Control")
    }
}








// MARK: - Table Dispatch

// MARK: - Virtual Table
/// ``Virtual Table`` is used in `Inheritance`
/// For every class and it's subclass ``Virual table`` is used
/// This helps to find appropriate <link to> method implementation / instructions for CPU

/// `OOP is preserved` - ``advantage``
/// `Slower than Direct Dispatch` - **disadvantage**
/// `Extension of the class does not extend the table` - **disadvantage**


// MARK: Example 1 - Virtual Table
/// Separate ``Virtual Table`` is created for each of classes
/// a    ` ---------------------------- `      ` ---------------------------- `
/// a    `|`              ClassExample5                   `|`      `|`              SubclassExample5              `|`
/// a    `|----------------------------|`       `|----------------------------|`
/// a    `|`         ClassExample5    `|` 0xxB1C`|`      `|`  SubclassExample5      `|`0xxB1C `|`
/// a    `|-------------------|--------|`       `|-------------------|--------|`
/// a    `|`        doSomething()      `|` 0xx9C2`|`       `|`        doSomething()       `|` 0xx8D1`|`
/// a    ` ---------------------------- `       `|-------------------|--------|`
/// a                                                                                  `|`       doSomething2()      `|` 0xx7A9`|`
/// a                                                                                  ` ---------------------------- `
///
class ClassExample5 {
    func doSomething() {
        print("Example 5 - Virtual Table")
    }
}

class SubclassExample5: ClassExample5 {
    override func doSomething() {
        print("Override for subclass")
    }

    func doSomething2() {
        print("Method of subclass")
    }
}



// MARK: - Virtual Table
/// ``Witness Table``  is used with `Protocol`
/// For every class that is conforming/implementing to a protocol

/// `Plymorphism` - ``advantage``
/// `Slower than Direct Dispatch` - **disadvantage**
/// `Inheritance is not presented` - **disadvantage**

// MARK: Example 6 - Witness Table
/// a    ` ---------------------------- `      ` ---------------------------- `
/// a    `|`              ClassExample6                   `|`      `|`           AnotherClassExample6          `|`
/// a    `|----------------------------|`       `|----------------------------|`
/// a    `|`      ProtocolExample6   `|`0xxCD0`|`       `|`    ProtocolExample6     `|`0xxCD0`|`
/// a    `|-------------------|--------|`       `|-------------------|--------|`
/// a    `|`        doSomething()      `|` 0xx1D2`|`       `|`        doSomething()       `|`0xxFO4`|`
/// a    ` ---------------------------- `       ` ---------------------------- `
///
protocol ProtocolExample6 {
    func doSomething()
}

class ClassExample6: ProtocolExample6 {
    func doSomething() {
        print("Example 6 - Witness Table")
    }
}

class AnotherClassExample6: ProtocolExample6 {
    func doSomething() {
        print("Hello World")
    }
}








// MARK: - Message Dispatch
/// The most `Dynamic` Dispatch that uses `Objective-C`
/// It works during `Runtime`
/// It iin the base of KVO (and in reactive programming), UIAppearance, CoreData.

/// Since it works during Runtime, method implementation can be changes. It is called `Method Swizziling`

/// It is often used during `Testing`
/// Less in `Prod`
/// Because it is not safe enough

/// `Method Swizziling` - ``advantage``
/// `The most dynamic` - ``advantage``
/// `The slowest Dispatch` - **disadvantage**

/// To implement ``Message Dispatch`` prefix `@objc dynamic` is used. Or `@objcMembers` before `class` -> all methods become `@objc` by default



// MARK: Example 7 - All types of dispatching
/// Here, all the Dispatchs are included
/// But ``Message Dispatch`` is discussed
/// During `Runtim` when `doSomething` is called
/// First look up is done in `Subclass`
/// If not found, then in` ParrentClass`
/// if not found, then in `NSObject`
///  if method is used with `performSelector` and not found then we get `crash` with error **NSInvalidArgumentException: unrecognized selector sent to instance**
///
protocol ProtocolExample7 {
    func doSomethingWithWitnessTable()
}

class ClassExample7: NSObject {
    @objc dynamic func doSomething() {
        print("Example 7 - Message Dispatch")
    }
}

class SubclassExample7: ClassExample7, ProtocolExample7 {
    private func doSomethingWithDirectDispatch() {
        print("Direct Dispatch")
    }
    func doSomethingWithVirtualTable() {
        print("Virtual Table")
    }
    func doSomethingWithWitnessTable() {
        print("Witness Table")
    }
    @objc override dynamic func doSomething() {
        print("Override with Message Dispatch")
    }
}





// MARK: - Bug
/// There are some bugs around Method Dispatch
/// But with updates they are being fixed
///
/// Here is one bug that is still present
print("\n\n")

// MARK: Example 8 - First Bug
/// We should see `Required Implementation` prented 2 times
/// Howerver, in the second case `Default Implementation` is used and that is ``Direct Dispatch``
/// But we implemented our own `doSomething` in the class. And that is ``Witness Tabel``

protocol ProtocolExample8 {}

extension ProtocolExample8 {
    func doSomething() {
        print("Default Implementation")
    }
}

class ClassExample8: ProtocolExample8 {
    func doSomething() {
        print("Required Implementation")
    }
}

let first = ClassExample8()
let second: ProtocolExample8 = ClassExample8()
first.doSomething()
second.doSomething()
print("\n")


/// To fix it wee need to add ``blueprint`` of the method in `protocol`

protocol ProtocolExample9 {
    func doSomething()
}

extension ProtocolExample9 {
    func doSomething() {
        print("Default Implementation")
    }
}

class ClassExample9: ProtocolExample9 {
    func doSomething() {
        print("Required Implementation")
    }
}

let first2 = ClassExample9()
let second2: ProtocolExample9 = ClassExample9()
first2.doSomething()
second2.doSomething()
