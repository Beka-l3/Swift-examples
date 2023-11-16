import Foundation


final class SomeClass {
    
    let someInt = 5
    
    
    var someClosure: (() -> Void)?
    
    init() {
        let aaaa = 1
        someClosure = { [weak self] in
            print("Some Closure says Hello from Some Class \(aaaa) \(self?.someInt)")
        }
    }
    
    deinit {
        someClosure?()
        print("hopa")
    }
    
}


var sc: SomeClass? = .init()
sc?.someClosure?()
var someRef = sc?.someClosure

sc?.someClosure = nil
sc = nil

print("asdasd")


someRef?()
print("qqq")



