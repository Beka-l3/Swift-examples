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





// MARK: Extensions with a Generic Where Clause
extension Stack where Element: Equatable {
    
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        
        return topItem == item
    }
    
}

func foo2() {
    var stackOfStrings = Stack<String>()
    stackOfStrings.push("uno")
    stackOfStrings.push("dos")
    stackOfStrings.push("tres")
    
    if stackOfStrings.isTop("tres") {
        print("Top element is tres.")
    } else {
        print("Top element is something else.")
    }
}

/// If you try to call the `isTop(_:) `method on a stack whose elements aren’t equatable, you’ll get a compile-time error.
struct NotEquatable { }
func foo3() {
    var notEquatableStack = Stack<NotEquatable>()
    let notEquatableValue = NotEquatable()
    notEquatableStack.push(notEquatableValue)
//    notEquatableStack.isTop(notEquatableValue)  // Error
}


extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}

func foo4() {
    if [9, 9, 9].startsWith(42) {
        print("Starts with 42.")
    } else {
        print("Starts with something else.")
    }
    // Prints "Starts with something else."
}


extension Container where Item == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}

func foo5() {
    print([1260.0, 1200.0, 98.6, 37.0].average())
    // Prints "648.9"
}




// MARK: Contextual Where Clausesin
/// You can write a generic where clause as part of a declaration that doesn’t have its own generic type constraints, when you’re already working in the context of generic types.
/// For example, you can write a generic where clause on a `subscript` of a generic type or on a `method` in an extension to a generic type.
/// The Container structure is generic, and the where clauses in the example below specify what type constraints have to be satisfied to make these new methods available on a container.
extension Container {
    
    func average() -> Double where Item == Int {
        var sum = 0.0
        
        for index in 0..<count {
            sum += Double(self[index])
        }
        
        return sum / Double(count)
    }
    
    func endsWith(_ item: Item) -> Bool where Item: Equatable {
        return count >= 1 && self[count-1] == item
    }
    
}

func foo6() {
    let numbers = [1260, 1200, 98, 37]
    
    print(numbers.average())
    // Prints "648.75"
    
    print(numbers.endsWith(37))
    // Prints "true"
}

/// If you want to write this code without using contextual where clauses, you write two extensions, one for each generic where clause. The example above and the example below have the same behavior.
/*
     extension Container where Item == Int {
         func average() -> Double {
             var sum = 0.0
             for index in 0..<count {
                 sum += Double(self[index])
             }
             return sum / Double(count)
         }
     }
     extension Container where Item: Equatable {
         func endsWith(_ item: Item) -> Bool {
             return count >= 1 && self[count-1] == item
         }
     }
*/




// MARK: Associated Types with a Generic Where Clause in
/// You can include a generic where clause on an associated type.
/// For example, suppose you want to make a version of Container that includes an iterator, like what the Sequence protocol uses in the Swift standard library

protocol Container2 {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }


    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}

/// For a protocol that inherits from another protocol, you add a constraint to an inherited associated type by including the generic where clause in the protocol declaration.
/// For example, the following code declares a ComparableContainer protocol that requires Item to conform to Comparable:
protocol ComparableContainer: Container where Item: Comparable { }



// MARK: Generic Subscriptsin
extension Container2 {
    
    subscript<Indices: Sequence>(indices: Indices) -> [Item] where Indices.Iterator.Element == Int {
        var result: [Item] = []
        
        for index in indices {
            result.append(self[index])
        }
        
        return result
    }
}

/// This extension to the Container protocol adds a subscript that takes a sequence of indices and returns an array containing the items at each given index. This generic subscript is constrained as follows:
/// - The generic parameter Indices in angle brackets has to be a type that conforms to the Sequence protocol from the Swift standard library.
/// - The subscript takes a single parameter, indices, which is an instance of that Indices type.
/// - The generic where clause requires that the iterator for the sequence must traverse over elements of type Int. This ensures that the indices in the sequence are the same type as the indices used for a container.



