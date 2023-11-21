import Foundation


/// ``Associated Types``
/// When defining a protocol, it’s sometimes useful to declare one or more associated types as part of the protocol’s definition.
/// An associated type gives a placeholder name to a type that’s used as part of the protocol.
/// The actual type to use for that associated type isn’t specified until the protocol is adopted.
/// Associated types are specified with the associatedtype keyword

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

/// The Container protocol defines three required capabilities that any container must provide:
/// - It must be possible to add a new item to the container with an `append(_:)` method.
/// - It must be possible to access a count of the items in the container through a count property that returns an Int value.
/// - It must be possible to retrieve each item in the container with a subscript that takes an Int index value.

/// This protocol doesn’t specify how the items in the container should be stored or what type they’re allowed to be.
/// The protocol only specifies the three bits of functionality that any type must provide in order to be considered a Container.
/// A conforming type can provide additional functionality, as long as it satisfies these three requirements

/// Any type that conforms to the Container protocol must be able to specify the type of values it stores.
/// Specifically, it must ensure that only items of the right type are added to the container, and it must be clear about the type of the items returned by its subscript.

/// To define these requirements, the Container protocol needs a way to refer to the type of the elements that a container will hold,
/// without knowing what that type is for a specific container.
/// The Container protocol needs to specify that any value passed to the `append(_:)` method must have the same type as the container’s element type,
/// and that the value returned by the container’s subscript will be of the same type as the container’s element type.

/// To achieve this, the Container protocol declares an associated type called Item, written as associatedtype Item.
/// The protocol doesn’t define what Item is — that information is left for any conforming type to provide.
/// Nonetheless, the Item alias provides a way to refer to the type of the items in a Container,
/// and to define a type for use with the `append(_:)` method and subscript, to ensure that the expected behavior of any Container is enforced.

/// Here’s a version of the nongeneric IntStack type from Generic Types above, adapted to conform to the Container protocol

struct IntStack: Container {
    // original IntStack implementation
    var items: [Int] = []
    
    mutating func push(_ item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    
    // conformance to the Container protocol
    typealias Item = Int
    
    mutating func append(_ item: Int) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
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










