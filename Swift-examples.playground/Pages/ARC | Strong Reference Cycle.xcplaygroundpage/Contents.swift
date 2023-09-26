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
var c1: Car? = Car(name: "Yamaha")
