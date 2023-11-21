import Foundation


/// ``Generic`` code enables you to write flexible, reusable functions and types that can work with any type, subject to `requirements` that you define.
/// You can write code that `avoids duplication` and expresses its intent in a `clear`, `abstracted` manner


/// Here’s a standard, nongeneric function called swapTwoInts(_:_:), which swaps two Int values:
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
    

func foo1() {
    var someInt = 3
    var anotherInt = 107
    swapTwoInts(&someInt, &anotherInt)
    print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
    // Prints "someInt is now 107, and anotherInt is now 3"
}

/// but it can be used only for Int

/// This is Generic version
/// That can swap any type
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

/// `<T>` is called `Type Parameters`
/// Then It can be used in function as definition of types
/// You can provide more than one type parameter by writing multiple type parameter names within the angle brackets, separated by commas





// MARK: Generic Type

// Not Generic: Int Stack
struct IntStack {
    var items: [Int] = []
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}


// Generic Stack
struct Stack<Element> {
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}
    
func foo2() {
    var stackOfStrings = Stack<String>()
    stackOfStrings.push("uno")
    stackOfStrings.push("dos")
    stackOfStrings.push("tres")
    stackOfStrings.push("cuatro")
    // the stack now contains 4 strings
    
    let fromTheTop = stackOfStrings.pop()
    // fromTheTop is equal to "cuatro", and the stack now contains 3 strings
    
}


// Extension of Generics
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}
 

func foo3() {
    var stackOfStrings = Stack<String>()
    stackOfStrings.push("uno")
    stackOfStrings.push("dos")
    stackOfStrings.push("tres")
    stackOfStrings.push("cuatro")
    // the stack now contains 4 strings
    
    let fromTheTop = stackOfStrings.pop()
    
    if let topItem = stackOfStrings.topItem {
        print("The top item on the stack is \(topItem).")
    }
    // Prints "The top item on the stack is tres."
}



// MARK: Type Constraints
/// The `swapTwoValues(_:_:)` function and the Stack type can work with any type.
/// However, it’s sometimes useful to enforce certain type constraints on the types that can be used with generic functions and generic types.
/// Type constraints specify that a type parameter must `inherit` from a specific `class`, or `conform` to a particular `protocol` or `protocol composition`

/// For example, Swift’s Dictionary type places a limitation on the types that can be used as keys for a dictionary.
/// As described in Dictionaries, the type of a dictionary’s keys must be hashable. That is, it must provide a way to make itself uniquely representable
/// Dictionary needs its keys to be hashable so that it can check whether it already contains a value for a particular key

// Syntax
class SomeClass {
    let a = 1

    func saySome() {
        print("some")
    }
}

protocol SomeProtocol {
    func hello()
}

func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    // function body goes here
}




// Example
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? { // Not Generic
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

func foo4() {
    let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
    if let foundIndex = findIndex(ofString: "llama", in: strings) {
        print("The index of llama is \(foundIndex)")
    }
    // Prints "The index of llama is 2"
}
    
// Here’s how you might expect a generic version of findIndex(ofString:in:), called findIndex(of:in:), to be written.
// Note that the return type of this function is still Int?,
// because the function returns an optional index number, not an optional value from the array.
// Be warned, though — this function doesn’t compile
/*
    func findIndex<T>(of valueToFind: T, in array:[T]) -> Int? {
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }
*/


// This function doesn’t compile as written above.
// The problem lies with the equality check, “if value == valueToFind”.
// Not every type in Swift can be compared with the equal to operator (==)
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}




