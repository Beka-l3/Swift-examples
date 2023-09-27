import Foundation

/// Structures and Enumerations are `value types`
/// A value type is a type whose value is copied when it’s assigned to a variable or constant, or when it’s passed to a function.

/// ``Copy on change``
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

/// The same behavior applies to enumerations
enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection.turnNorth()

print("The current direction is \(currentDirection)")
print("The remembered direction is \(rememberedDirection)\n\n")


/// Unlike value types, reference types are not copied when they’re assigned to a variable or constant,
/// or when they’re passed to a function.
/// Rather than a copy, a reference to the same existing instance is used.

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

