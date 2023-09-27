import Foundation

/// Structures and Enumerations are `value types`
/// A value type is a type whose value is copied when it’s assigned to a variable or constant, or when it’s passed to a function.

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












