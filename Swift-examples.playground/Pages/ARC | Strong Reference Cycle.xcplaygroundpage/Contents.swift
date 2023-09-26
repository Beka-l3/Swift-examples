import Foundation

/// Sometimes  setting a variable to `nil` in inappropriate way may not lead to freeing up the memory
/// An example of it is `Strong Reference Cycle`
/// This leads to `Memory leak`

/// For example if we have an object and it has an property that can point to another object
/// And we create 2 objects and set thier properties to point each other
/// Congrats, we have an `Strong Refernce Cycle`
/// Then if we set `var` of those objects to `nil`
/// Congrats, now we have an `Memory leak`
/// Since we have those properties to point to instances, `RC != 0` for both instances
/// And we do not have access to objects
/// They are in the memory and we cannot remove them

final class Person {
    let name: String
    var friend: Person?
    
    init(name: String) {
        self.name = name
        print("Person has born: \(name)")
    }
    
    deinit {
        print("Person is dead: \(name)")
    }
}

var p1: Person? = Person(name: "Kamil")
var p2: Person? = Person(name: "Kamil")
print()

print("Current refferences look like this\n")
print("Kamil        Yerzhan  ")
print(" ^             ^      ")
print(" |             |      ")
print(" p1            p2     ")
print("\n")

p1?.friend = p2
p2?.friend = p1
print("Now we have strong reference cycle")
print("Current refferences look like this\n")
print("Kamil <----> Yerzhan  ")
print(" ^             ^      ")
print(" |             |      ")
print(" p1            p2     ")
print("\n")


p1 = nil
p2 = nil
print("Now Kamil and Yerzhan has not deinited")
print("Because their RC != 0\n")
print("Kamil's property friend is pointing to Yerzhan")
print("Yerzhan's property friend is pointing to Kamil\n")
print("Even if")
print("p1 is pointing to 'nil'")
print("p2 is pointing to 'nil'")
print()
print("Current refferences look like this\n")
print("Kamil <----> Yerzhan  ")
print("                      ")
print("                      ")
print(" p1            p2     ")
print(" |             |      ")
print(" ˇ             ˇ      ")
print(" nil           nil    ")
print("\n")



