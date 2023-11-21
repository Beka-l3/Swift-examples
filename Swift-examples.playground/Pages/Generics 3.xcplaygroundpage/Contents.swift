import Foundation


// MARK: Generic Where Clauses
/// Type constraints enable you to define requirements on the type parameters associated with a generic function, subscript, or type

/// It can also be useful to define requirements for associated types.
/// You do this by defining a generic ``where clause``.

/// A generic where clause enables you to require that an associated type must conform to a certain protocol, or that certain type parameters and associated types must be the same.
/// A generic where clause starts with the where keyword, followed by constraints for associated types or equality relationships between types and associated types.
/// You write a generic where clause right before the opening curly brace of a type or function’s body.

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool where C1.Item == C2.Item, C1.Item: Equatable {

    // Check that both containers contain the same number of items.
    if someContainer.count != anotherContainer.count {
        return false
    }

    // Check each pair of items to see if they're equivalent.
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }

    // All items match, so return true.
    return true
}

struct Stack<Element>: Container {
    
    // original Stack<Element> implementation
    var items: [Element] = []
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    
    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Element {
        return items[i]
    }
}

extension Array: Container { }

func foo1() {
    
    var stackOfStrings = Stack<String>()
    stackOfStrings.push("uno")
    stackOfStrings.push("dos")
    stackOfStrings.push("tres")

    var arrayOfStrings = ["uno", "dos", "tres"]

    if allItemsMatch(stackOfStrings, arrayOfStrings) {
        print("All items match.")
    } else {
        print("Not all items match.")
    }
    // Prints "All items match."
    
}


