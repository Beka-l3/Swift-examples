import Foundation

/// A strong reference cycle can also occur
/// if you assign a closure to a property of a class instance,
/// and the body of that closure captures the `instance`.
/// This capture might occur because the closure’s body accesses a property of the instance, such as `self.someProperty`
/// or because the closure calls a method on the instance, such as `self.someMethod()`
///
/// Closures are `reference types`

class HTMLElement {

    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }

}

/// The asHTML property is named and used somewhat like an instance method.
/// However, because asHTML is a closure property rather than an instance method,
/// you can replace the default value of the asHTML property with a custom closure,
/// if you want to change the HTML rendering for a particular HTML element.

/// example

let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())


/// The asHTML property is declared as a lazy property,
/// because it’s only needed if and when the element actually needs to be rendered as a string value for some HTML output target.
/// The fact that asHTML is a lazy property means that you can refer to self within the default closure,
/// because the lazy property will not be accessed until after initialization has been completed and self is known to exist.


var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())

print("Above codes create SRC")
print("Take var pragraph as an example\n")


print("Current refferences look like this\n")

print(" paragraph -----> p: hellow world          ")
print("                     |     ^               ")
print("                     |     |               ")
print("                     ˇ     |               ")
print("                closure: () -> String      ")
print("\n")

paragraph = nil

print("Dinit is not called because of SRC\n")

print("To prevent this by defining a capture list")

/// As with strong reference cycles between two class instances,
/// you declare each captured reference to be a weak or unowned reference rather than a strong reference.
/// The appropriate choice of weak or unowned depends on the relationships between the different parts of your code.

/// Swift requires you to write self.someProperty or self.someMethod() (rather than just someProperty or someMethod())
/// whenever you refer to a member of self within a closure.
/// This helps you remember that it’s possible to capture self by accident.

print("\n\n")

// MARK: - Resolve SRC
protocol SomeDelegate: AnyObject { }

final class SomeClass {
    
    var delegate: SomeDelegate?
    
    /// Each item in a capture list is a pairing of the weak or unowned keyword with a reference to a class instance (such as self)
    /// or a variable initialized with some value (such as delegate = self.delegate).
    /// These pairings are written within a pair of square braces, separated by commas.
    lazy var someClosure = { [unowned self, weak delegate = self.delegate] (index: Int, stringToProcess: String) -> String in
        
        return ""
    }
    
    /// if a closure doesn’t specify a parameter list or return type because they can be inferred from context,
    /// place the capture list at the very start of the closure, followed by the `in` keyword:
    lazy var someClosure2 = { [unowned self, weak delegate = self.delegate] in
        
    }
    
    init() {
        
    }
    
}


class HTMLElement2 {

    let name: String
    let text: String?

    /// If the captured reference will never become `nil`,
    /// it should always be captured as an unowned reference, rather than a weak reference.
    lazy var asHTML: () -> String = { [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}

var paragraph2: HTMLElement2? = HTMLElement2(name: "p", text: "hello, world")
print(paragraph2!.asHTML())

print("Current refferences look like this\n")

print(" paragraph -----> p: hellow world          ")
print("                     |     ^               ")
print("                     |     :               ")
print("                     ˇ     :               ")
print("                closure: () -> String      ")
print("\n")

paragraph2 = nil





