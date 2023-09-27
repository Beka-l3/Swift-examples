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


// MARK: - Resolve SRC










