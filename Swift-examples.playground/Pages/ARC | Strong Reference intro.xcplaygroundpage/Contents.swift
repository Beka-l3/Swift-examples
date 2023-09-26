import Foundation

final class Person {
    let name: String
    var vehicle: Car?
    
    init(name: String) {
        self.name = name
        print("Person has be initialized: \(name)")
    }
    
    deinit {
        print("Person is being deinitilized: \(name)")
    }
}

final class Car {
    let name: String
    var owner: Person?
    
    init(name: String) {
        self.name = name
        print("Car has been initialized: \(name)")
    }
    
    deinit {
        print("Car is being deinitilized: \(name)")
    }
}

var p1: Person? = Person(name: "Ulan")
var p2: Person? = Person(name: "Zhanat")
var p3: Person? = Person(name: "Berik")
var p4: Person? = Person(name: "Shalkar")

var c1: Car? = Car(name: "Yamaha")
var c2: Car? = Car(name: "Mercedes")
var c3: Car? = Car(name: "GTR")
var c4: Car? = Car(name: "BMW")

print("Current refferences look like this\n")
print("Ulan         Zhanat         Berik         Shalkar")
print(" ^             ^              ^              ^   ")
print(" |             |              |              |   ")
print(" p1            p2             p3             p4  ")
print("\n")
print("Yamaha      Mercedes         GTR            BMW  ")
print(" ^             ^              ^              ^   ")
print(" |             |              |              |   ")
print(" c1            c2             c3             c4  ")
print()
print("Each variable is pointing to one instance")
print("And their properties are not pointing to other instance")
print()

p1?.vehicle = c1
c1?.owner = p2

p2?.vehicle = c2
c2?.owner = p3

p3?.vehicle = c3
c3?.owner = p4

p4?.vehicle = c4

print("Now we set their properties to point to other instances")
print("But to p1: Ulan has only one refernce")
print("And property of c4: BMW is not pointing to other instance")
print()
print("Current refferences look like this\n")
print(" Ulan        Zhanat        Berik       Shalkar   ")
print(" ^  |       /  ^  |       /  ^  |     / ^    |   ")
print(" |  |      /   |  |      /   |  |    /  |    |   ")
print(" p1 |     /    p2 |     /    p3 |   /   p4   |   ")
print("    |    /        |    /        |  /         |   ")
print("    ˇ   /         ˇ   /         ˇ /          ˇ   ")
print("  Yamaha       Mercedes         GTR         BMW  ")
print("   ^             ^              ^            ^   ")
print("   |             |              |            |   ")
print("   c1            c2             c3           c4  ")
print()

c1 = nil

p2 = nil
c2 = nil

p3 = nil
c3 = nil

p4 = nil
c4 = nil

print("Even if they are set to be \"nil\", they are not deinited")
print("Because their reffenrece count is not 0\n")
print()
print("Current refferences look like this\n")
print(" Ulan      Zhanat        Berik      Shalkar   ")
print(" ^  |      /  |          /   |      /     |   ")
print(" |  |     /   |         /    |     /      |   ")
print(" p1 |    /    |        /     |    /       |   ")
print("    |   /     |       /      |   /        |   ")
print("    ˇ  /      ˇ      /       ˇ  /         ˇ   ")
print("   Yamaha     Mercedes       GTR         BMW  ")
print()

p1 = nil
print()

print("And now when we set p1 to be \"nil\" and Ulan is deinited")
print("Because now    Ulan's      reference count = 0")
print("Which lead to  Yamaha's    reference count = 0")
print("Which lead to  Zhanat's    reference count = 0")
print("Which lead to  Mercedes's  reference count = 0")
print("Which lead to  Berik's     reference count = 0")
print("Which lead to  GTR's       reference count = 0")
print("Which lead to  Shalkar's   reference count = 0")
print("Which lead to  BMW's       reference count = 0")
print()


