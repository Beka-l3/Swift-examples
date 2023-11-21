import Foundation


/// ``Generic`` code enables you to write flexible, reusable functions and types that can work with any type, subject to `requirements` that you define.
/// You can write code that `avoids duplication` and expresses its intent in a `clear`, `abstracted` manner


/// Here’s a standard, nongeneric function called swapTwoInts(_:_:), which swaps two Int values:
func foo1() {
    func swapTwoInts(_ a: inout Int, _ b: inout Int) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    var someInt = 3
    var anotherInt = 107
    swapTwoInts(&someInt, &anotherInt)
    print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
    // Prints "someInt is now 107, and anotherInt is now 3"
    
    /// but it can be used only for Int
    
    /// This is Generic version
    /// That can swap any type
    func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
}

/// `<T>` is called `Type Parameters`
/// Then It can be used in function as definition of types
/// You can provide more than one type parameter by writing multiple type parameter names within the angle brackets, separated by commas


// MARK: Generic Type
func foo2() {
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
    
    var stackOfStrings = Stack<String>()
    stackOfStrings.push("uno")
    stackOfStrings.push("dos")
    stackOfStrings.push("tres")
    stackOfStrings.push("cuatro")
    // the stack now contains 4 strings
    
    let fromTheTop = stackOfStrings.pop()
    // fromTheTop is equal to "cuatro", and the stack now contains 3 strings
}






