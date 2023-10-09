import Foundation

/// There are 2 ways to prevent Strong Reference Cycle
/// ``weak`` `var`
/// ``unowned``  `var`
/// They both are the mechanisms that ``does not increase`` ` Reference Count (RC)`
/// The difference is that ``unowned`` guaranties that the object is not `nil`
/// If the object is deinited then ``weak`` points to `nil`
/// however ``unowned`` will cause `runtime error`
/// Use a ``weak`` reference when the other instance has a `shorter` `lifetime` — that is, when the other instance can be deallocated first.
/// Use an ``unowned`` reference when the other instance has the `same` `lifetime` or a `longer` `lifetime`.

/// ``Weak`` Property observers aren’t called when `ARC` sets a weak reference to `nil`.

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
func foo1() {
    var p1: Person? = Person(name: "Bekzhan")
    var i1: Baloon? = Baloon(color: .red)
    print()
    
    print("Current refferences look like this\n")
    print(" p1 ----->  Bekzhan       ")
    print("                          ")
    print(" i1 ----->  Red Balooon   ")
    print("\n\n")
    
    
    p1?.itemOnHand = i1
    i1?.owner = p1
    
    print("Current refferences look like this\n")
    print(" p1 ----->  Bekzhan       ")
    print("            |   ^         ")
    print("            |   :         ")
    print("            |   :         ")
    print("            ˇ   :         ")
    print(" i1 ----->  Red Balooon   ")
    print("\n\n")
    
    
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
    print("\n\n")
    
    p1 = nil
    print("Current refferences look like this\n")
    print(" p1         Bekzhan       ")
    print("                          ")
    print(" i1         Red Balooon   ")
    print("\n\n")
}
//foo1()


/// example 2
func foo2() {
    var p2: Person? = Person(name: "Zhangir")
    var i2: Baloon? = Baloon(color: .blue)
    p2?.itemOnHand = i2
    i2?.owner = p2
    
    print("Current refferences look like this\n")
    print(" p2 ----->  Zhangir       ")
    print("            |   ^         ")
    print("            |   :         ")
    print("            |   :         ")
    print("            ˇ   :         ")
    print(" i2 ----->  Blue Balooon  ")
    print("\n\n")
    
    print(i2?.owner ?? "some")
    p2 = nil
    print(i2?.owner ?? "nil", "\n\n")
    
    
    print("Since weak does not increase RC")
    print("When p2 is set to nil")
    print("Zhangir has been deinted immediately")
    print("And Blue Baloon's owner is nil, too'n")
    
    print("Current refferences look like this\n")
    print(" p2         Zhangir       ")
    print("                          ")
    print(" i2 ----->  Blue Balooon  ")
    print("\n\n")
}
//foo2()


// MARK: - Method 2         unowned

/// We can make `unowned` property as `let`
/// because we guarantee that it is always has a value
/// but ARC will not count a strong reference

/// example 1
final class Customer {
    let name: String
    var card: CreditCard?
    
    init(name: String) {
        self.name = name
        print("This person has registered in our bank: \(name)")
    }
    
    deinit {
        print("Our client left our bank: \(name)")
    }
}

final class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
        print("Card got it's customer: #\(number), \(customer.name)")
    }
    deinit { print("Card lost it's owner: #\(number)") }
}

func foo3() {
    var beka: Customer?
    beka = Customer(name: "Bekzhan Talgat")
    beka!.card = CreditCard(number: 1234_5678_9012_3456, customer: beka!)
    
    print("Current refferences look like this\n")
    
    print(" p1 -----> Beka           ")
    print("           |  ^           ")
    print("           |  :           ")
    print("           ˇ  :           ")
    print("           Card           ")
    print("\n")
    
    beka = nil
    
    print("In CreditCards deinit, we cannot access customer, because it is already deinited\n")
    print("\n")
}
//foo3()


/// example 2
/// `unowned` can be also a `var` and `Optional`
/// And it will behave like a `weak`
class Department {
    var name: String
    var courses: [Course]
    init(name: String) {
        self.name = name
        self.courses = []
    }
}

class Course {
    var name: String
    unowned var department: Department
    unowned var nextCourse: Course?
    init(name: String, in department: Department) {
        self.name = name
        self.department = department
        self.nextCourse = nil
    }
}


/// example 3
/// `unowned` can be `Implicitly Unwrapped Optional`
/// It will be like a just `Optional` and default value is `nil`
/// This means that the `capitalCity` property has a default value of `nil`,
/// like any other `optional`,
/// but can be accessed without the need to unwrap its value as described in
class Country {
    let name: String
    var capitalCity: City!
    
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
        print("Country is inited")
    }
    
    deinit {
        print("Country is deinited")
    }
}


class City {
    let name: String
    unowned let country: Country
    
    init(name: String, country: Country) {
        self.name = name
        self.country = country
        print("City is inited")
    }
    
    deinit {
        print("City is deinited")
    }
}

func foo5() {
    var cntr = Country(name: "KZ", capitalName: "Satana")
}
//foo5()
var cntr: Country? = Country(name: "KZ", capitalName: "Satana")

print(cntr!.capitalCity.name)
cntr!.capitalCity = nil
print(cntr!.capitalCity ?? "nil")
cntr = nil


