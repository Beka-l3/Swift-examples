import Foundation

/// There are 2 ways to prevent Strong Reference Cycle
/// ``weak`` `var`
/// ``unowned``  `var`
/// They both are the mechanisms that ``does not increase`` `Reference Count (RC)`
/// The difference is that ``unowned`` guaranties that the object is not `nil`
/// If the object is deinited then ``weak`` points to `nil`
/// however ``unowned`` will cause `runtime error`
/// Use a weak reference when the other instance has a shorter lifetime — that is, when the other instance can be deallocated first.
/// Use an unowned reference when the other instance has the same lifetime or a longer lifetime.

/// ``Weak`` Property observers aren’t called when ARC sets a weak reference to nil.

// MARK: - Method 1      weak
final class Person {
    let name: String
    var itemOnHand: Baloon?
    
    init(name: String) {
        self.name = name
        print("Person has born: \(name)")
    }
    
    deinit {
        print("Person is dead: \(name)")
    }
}

final class Baloon {
    enum Colour {
        case red, green, blue
    }
    
    let color: Colour
    weak var owner: Person?
    
    init(color: Colour) {
        self.color = color
        print("Baloon has been blown: \(color)")
    }
    
    deinit {
        print("Baloon is gone: \(color)")
    }
}


/// example 1
var p1: Person? = Person(name: "Bekzhan")
var i1: Baloon? = Baloon(color: .red)
print()

print("Current refferences look like this\n")

print(" p1 ----->  Bekzhan       ")
print("                          ")
print(" i1 ----->  Red Balooon   ")
print("\n")


p1?.itemOnHand = i1
i1?.owner = p1
print()

print("Current refferences look like this\n")

print(" p1 ----->  Bekzhan       ")
print("            |   ^         ")
print("            |   :         ")
print("            |   :         ")
print("            ˇ   :         ")
print(" i1 ----->  Red Balooon   ")
print("\n")


i1 = nil
print("Now i1 points to 'nil'")
print("p1 points to Bekzhan")
print("Bekzhan's itemOnHand points to Read Baloon")
print("Read Baloon's owner is weak var points to Bekzhan")
print("But weak reference does not increase RC")
print("So Bekzhan's RC == 1")
print("And Red Baloon's RC == 1\n")

print("Current refferences look like this\n")

print(" p1 ----->  Bekzhan       ")
print("            |   ^         ")
print("            |   :         ")
print("            |   :         ")
print("            ˇ   :         ")
print(" i1         Red Balooon   ")
print("\n")

p1 = nil
print()
print("Current refferences look like this\n")

print(" p1         Bekzhan       ")
print("                          ")
print(" i1         Red Balooon   ")
print("\n\n")


/// example 2
var p2: Person? = Person(name: "Zhangir")
var i2: Baloon? = Baloon(color: .blue)
p2?.itemOnHand = i2
i2?.owner = p2
print()

print("Current refferences look like this\n")

print(" p1 ----->  Zhangir       ")
print("            |   ^         ")
print("            |   :         ")
print("            |   :         ")
print("            ˇ   :         ")
print(" i1 ----->  Blue Balooon  ")
print("\n")

p2 = nil
print()

print("Since weak does not increase RC")
print("When p2 is set to nil")
print("Zhangir has been deinted immediately")
print("And Blue Baloon's owner is nil, too'n")

print("Current refferences look like this\n")

print(" p1         Zhangir       ")
print("                          ")
print(" i1 ----->  Blue Balooon  ")
print("\n")

