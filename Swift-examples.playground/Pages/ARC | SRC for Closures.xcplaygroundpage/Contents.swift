import Foundation

/// A strong reference cycle can also occur
/// if you assign a closure to a property of a class instance,
/// and the body of that closure captures the `instance`.
/// This capture might occur because the closure’s body accesses a property of the instance, such as `self.someProperty`
/// or because the closure calls a method on the instance, such as `self.someMethod()`
///
/// Closures are `reference types`



