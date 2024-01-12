import Foundation


/// Closures are self-contained blocks of functionality that can be passed around and used in your code.
/// Closures in Swift are similar to blocks in C and Objective-C and to lambdas in other programming languages.

/// Closures can capture and store references to any constants and variables from the context in which they’re defined.
/// This is known as closing over those constants and variables. Swift handles all of the memory management of capturing for you.


// MARK: - Capture List
/// A closure can capture constants and variables from the surrounding context in which it’s defined.
/// The closure can then refer to and modify the values of those constants and variables from within its body,
/// even if the original scope that defined the constants and variables no longer exists

/// In Swift, the simplest form of a closure that can capture values is a nested function, written within the body of another function.
/// A nested function can capture any of its outer function’s arguments and can also capture any constants and variables defined within the outer function

/// Here’s an example of a function called makeIncrementer, which contains a nested function called incrementer.
/// The nested incrementer() function captures two values, runningTotal and amount, from its surrounding context.
/// After capturing these values, incrementer is returned by makeIncrementer as a closure that increments `runningTotal` by amount each time it’s called.

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

/// The incrementer() function doesn’t have any parameters, and yet it refers to runningTotal and amount from within its function body.
/// It does this by capturing a ``reference`` to `runningTotal` and `amount` from the surrounding function and using them within its own function body

/// Capturing by reference ensures that runningTotal and amount don’t disappear when the call to makeIncrementer ends,
/// and also ensures that runningTotal is available the next time the incrementer function is called

/// As an optimization, Swift may instead capture and store a copy of a value if that value isn’t mutated by a closure, and if the value isn’t mutated after the closure is created.
/// Swift also handles all memory management involved in disposing of variables when they’re no longer needed.

let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
incrementByTen()
incrementByTen()

/// If you create a second incrementer, it will have its own stored reference to a new, separate runningTotal variable
let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()


// MARK: - Example 2

func foo1() {
    var num = 1
    
    /// No new reference is created. We are directly using the `var num` from `line 54`
    let buzz1 = {
        print(num)
    }
    
    buzz1()
    
    num += 1
    
    buzz1()
}


func foo2() {
    var num = 1
    
    /// here new instance is created (copy of num)
    let buzz2 = { [num] in
        print(num)
    }
    
    buzz2()
    
    num += 1
    
    buzz2()
}


// MARK: Example - 3
func foo3() {
    final class A {
        var num = 1
    }
    
    var a: A? = A()
    
    /// Here new reference to `a` is `not` created.  Now only 1 pointer is referencing `a`
    /// seems like exact copy of the address value is captured, so reference counting is not incremented
    ///     maybe even copy was not made, it is the same `var a` that we created on `line 91`
    let buzz4 = {
        print(a?.num ?? "nil")
    }
    
    buzz4()
    
    a?.num += 1
    
    buzz4()
    
    a = nil
    
    buzz4()
    
    print()
}
//foo3()

func foo4() {
    final class A {
        var num = 1
    }
    
    var a: A? = A()
    
    /// Here new reference(strong) to `a` is created. And now 2 pointers are referencing `a`
    let buzz4 = { [a] in
        print(a?.num ?? "nil")
    }
    
    buzz4()
    
    a?.num += 1
    
    buzz4()
    
    a = nil
    
    buzz4()
    
    print()
}
//foo4()





// MARK: - example 4
func foo5() {
    final class A {
        var num = 1
    }
    
    final class B {
        var a: A?
        
        lazy var buzz = { [unowned self] in
            print(self.a?.num ?? "nil")
        }
        
        init(a: A? = nil) {
            self.a = a
        }
        
        deinit {
            print("Deinited")
        }
    }
    
    
    let a = A()
    var b: B? = B(a: a)
    
    b?.buzz()
    
    b = nil
}
//foo5()
