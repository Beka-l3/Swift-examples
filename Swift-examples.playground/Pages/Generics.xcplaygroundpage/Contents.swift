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










