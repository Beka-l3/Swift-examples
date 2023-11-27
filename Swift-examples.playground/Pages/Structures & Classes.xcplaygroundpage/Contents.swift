import Foundation

/// Structures and Enumerations are `value types`
/// A value type is a type whose value is copied when it’s assigned to a variable or constant, or when it’s passed to a function.

/// ``Copy on write``
/// `Collections` defined by the standard library like arrays, dictionaries, and strings
/// use an optimization to reduce the performance cost of copying.
/// Instead of making a copy immediately,
/// these collections share the memory where the elements are stored between the original instance and any copies.
/// If one of the copies of the collection is modified, the elements are copied just before the modification.
/// The behavior you see in your code is always as if a copy took place immediately.

struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

func foo1() {
    let hd = Resolution(width: 1920, height: 1080)
    print("Current refferences look like this\n")
    print(" hd ---------> 1920x1080          ")
    print("\n")
    
    var cinema = hd
    
    ///  Because Resolution is a structure, a copy of the existing instance is made, and this new copy is assigned to cinema.
    ///  Even though hd and cinema now have the same width and height, they’re two completely different instances behind the scenes.
    
    print("Current refferences look like this\n")
    print(" hd ---------> 1920x1080          ")
    print("                                  ")
    print(" cinema -----> 1920x1080          ")
    print("\n")
    
    cinema.width = 2048
    
    print("Current refferences look like this\n")
    print(" hd ---------> 1920x1080          ")
    print("                                  ")
    print(" cinema -----> 2048x1080          ")
    print("\n")
}
//foo1()

/// The same behavior applies to enumerations
enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}
func foo2() {
    var currentDirection = CompassPoint.west
    let rememberedDirection = currentDirection
    currentDirection.turnNorth()
    
    print("The current direction is \(currentDirection)")
    print("The remembered direction is \(rememberedDirection)\n\n")
}
//foo2()

/// Unlike value types, reference types are not copied when they’re assigned to a variable or constant,
/// or when they’re passed to a function.
/// Rather than a copy, a reference to the same existing instance is used.

func foo3() {
    let hd = Resolution(width: 1920, height: 1080)
    
    let tenEighty = VideoMode()
    tenEighty.resolution = hd
    tenEighty.interlaced = true
    tenEighty.name = "1080i"
    tenEighty.frameRate = 25.0
    
    let alsoTenEighty = tenEighty
    
    print("Current refferences look like this\n")
    print(" tenEighty ---------> frame rate: 25.0  ")
    print("                        ^               ")
    print("                        |               ")
    print("                        |               ")
    print("                 alsoTenEighty          ")
    print("\n")
    
    alsoTenEighty.frameRate = 30.0
    
    print("The frameRate property of tenEighty is now \(tenEighty.frameRate)\n")
    
    
    print("Current refferences look like this\n")
    print(" tenEighty ---------> frame rate: 30.0  ")
    print("                        ^               ")
    print("                        |               ")
    print("                        |               ")
    print("                 alsoTenEighty          ")
    print("\n")
}
//foo3()


// MARK: - Identity operator
/// It can sometimes be useful to find out whether two constants or variables refer to exactly the same instance of a class.
/// To enable this, Swift provides two identity operators:
/// Identical to `===`
/// Not identical to `!==`


// MARK: - Comparison
/*
 
 Structures and classes in Swift have many things in common. Both can:
 - Define properties to store values
 - Define methods to provide functionality
 - Define subscripts to provide access to their values using subscript syntax
 - Define initializers to set up their initial state
 - Be extended to expand their functionality beyond a default implementation
 - Conform to protocols to provide standard functionality of a certain kind
 
 Classes have additional capabilities that structures don’t have:
 - Inheritance enables one class to inherit the characteristics of another.
 - Type casting enables you to check and interpret the type of a class instance at runtime.
 - Deinitializers enable an instance of a class to free up any resources it has assigned.
 - Reference counting allows more than one reference to a class instance.
 
 */



// MARK: - Copy on write
func foo5() {
    func address(_ o: UnsafeRawPointer) {
        print("address: \(Int(bitPattern: o))")
    }
    
    var arr1 = [1, 2, 3]
    var arr2 = arr1
    
    address(arr1)
    address(arr2)
    
    arr2[0] = 2
    
    print()
    address(arr1)
    address(arr2)
}
foo5()


final class Ref<T> {
    var value: T
    init(_ v: T) { value = v }
}

struct Box<T> {
    private var ref: Ref<T>
    init(_ x: T) { ref = Ref(x) }
    
    var value: T {
        get { return ref.value }
        set {
            if !isKnownUniquelyReferenced(&ref) {
                ref = Ref(newValue)
                return
            }
            ref.value = newValue
        }
    }
}

func foo6() {
    struct Person  {
        var name: String
        var age: Int
        
        init(name: String, age: Int) {
            self.name = name
            self.age = age
        }
    }
    
    func printAddress(address o: UnsafeRawPointer ) {
        print(String(format: "%p", Int(bitPattern: o)))
    }
    
    var personObj1 = Box(Person(name: "Mike", age: 38))
    var personObj2 = personObj1
    
    print(personObj1.value) // Person(name: "Mike", age: 38)
    print(personObj2.value) // Person(name: "Mike", age: 38)
    
    printAddress(address: &personObj1.value) //0x16f7e6ed0
    printAddress(address: &personObj2.value) //0x16f7e6ed0
    
    personObj2.value.name = "Peter"
    print(personObj2.value) // Person(name: "Peter", age: 38)
    printAddress(address: &personObj2.value) // 0x16f7e6f70
}

/// `Advantages of copy-on-write in Swift`
/// - Improved Performance: CoW allows you to efficiently share value types across
///   multiple instances without the overhead of copying data until it actually changes.
///   This can significantly improve performance in situations where data is shared frequently and rarely changed.

/// - Reduced Memory Usage: When multiple references share the same instance of a value type,
///   only one copy of the data is kept in memory. This reduces memory usage and helps to avoid unnecessary duplication of data.

/// - Easy to Use: CoW is automatically handled by Swift for value types that are marked as copy-on-write.
///   This means that you don't need to write any special code to take advantage of CoW.


/// `Disadvantage of copy-on-write in Swift`
/// - Complexity: CoW can add a certain level of complexity to your code, especially when dealing with large data structures.
///   For example, you should be aware of the impact of CoW on reference counting behavior and memory management.

/// - Performance  Overhead: Although CoW is designed to improve performance in many cases,
///   there can be some performance overhead associated with it. For example, when data is frequently modified,
///   copying the data on every write operation can be expensive.

/// - Limited Support: Currently, CoW is only supported for certain value types in Swift, such as arrays and dictionaries.
///   If you need to use CoW with your custom value types, you’ll need to implement it yourself.
