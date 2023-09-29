import Foundation

/// ``Initialization`` is the process of preparing an instance of a class, structure, or enumeration for use.
/// This process involves setting an initial value for each `stored` property on that instance and performing any other setup or
/// initialization that’s required before the new instance is ready for use.

/// Instances of class types can also implement a ``deinitializer``

/// ...




// MARK: - Customizing Initializers

/// Parameters
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
// boilingPointOfWater.temperatureInCelsius is 100.0

let freezingPointOfWater = Celsius(fromKelvin: 273.15)
// freezingPointOfWater.temperatureInCelsius is 0.0


// MARK: Constant
/// For class instances, a constant property can be modified during initialization only by the class that introduces it.
/// It can’t be modified by a subclass.




// MARK: - Init Delegation
/// `Initializers` can call other `initializers` to perform `part` of an instance’s `initialization`.
/// This process, known as initializer delegation, avoids duplicating code across multiple initializers.
/// The rules for how initializer delegation works <and for what forms of delegation are allowed> are different for `value types` and `class types`




// MARK: - Value Types
/// Value types (structures and enumerations) `don’t support` `inheritance`,
/// and so their initializer delegation process is relatively simple,
/// because they can only delegate to another initializer that they provide `themselves`.
///
/// For value types, you use `self.init` to refer to other initializers from the same value type when writing your own custom initializers.
/// You can call `self.init` only from within an initializer.
///
/// **Note** that if you define a custom initializer for a value type,
/// you will no longer have access to the default initializer (or the memberwise initializer, if it’s a structure) for that type.
///
/// If you want your custom value type to be initializable with the `default initializer` and `memberwise initializer`, and
/// also with your own `custom initializers`,
/// write your `custom initializers` in an ``extension`` rather than as part of the value type’s original implementation.

struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    
    init() {}
    
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let basicRect = Rect()
// basicRect's origin is (0.0, 0.0) and its size is (0.0, 0.0)

let originRect = Rect(
    origin: Point(x: 2.0, y: 2.0),
    size: Size(width: 5.0, height: 5.0)
) // originRect's origin is (2.0, 2.0) and its size is (5.0, 5.0)

let centerRect = Rect(
    center: Point(x: 4.0, y: 4.0),
    size: Size(width: 3.0, height: 3.0)
) // centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)



// MARK: - Classes
/// Classes, however, can inherit from other classes
/// This means that classes have additional responsibilities for ensuring that `all stored properties` they inherit are assigned a suitable value during initialization.

/// All of a class’s `stored properties` — including any properties the class `inherits` from its superclass — must be assigned an initial value during initialization.
/// Swift defines two kinds of initializers for class types to help ensure all stored properties receive an initial value.
/// These are known as `designated` initializers and `convenience` initializers
/// Every class must have at least one designated initializer


// MARK: Designated
/// ``Designated initializers`` are the primary initializers for a class.
/// A designated initializer `fully initializes all properties` introduced by that class and
/// calls an appropriate `superclass initializer` to continue the initialization process up the superclass chain

// init(<#parameters#>) {
//    <#statements#>
// }


// MARK: Convenience
/// ``Convenience initializers`` are secondary, supporting initializers for a class.
/// You can define a convenience initializer to call a designated initializer from the same class as the convenience initializer with some of
/// the designated initializer’s parameters set to default values.
/// You can also define a convenience initializer to create an instance of that class for a specific use case or input value type

// convenience init(<#parameters#>) {
//    <#statements#>
// }


// MARK: Rules
/// 1) **A designated initializer must call a designated initializer from its immediate superclass.**
/// 2) **A convenience initializer must call another initializer from the same class.**
/// 3) ** A convenience initializer must ultimately call a designated initializer.**
///
/// - Designated initializers must always delegate up.
/// - Convenience initializers must always delegate across.


/*
 
 superclass:-------------------------------------------------------------
 |
 |             designated  <------ convenience  <--------- convenience
 |                     ^
  --------------------- \ ------------------------------------------------
                         \
 subclass:--------------- \ ----------------------------------------------
 |                         \
 |   convenience ------> designated  <-------- convenience
 |
  ------------------------------------------------------------------------
 
*/



// MARK: - Two Phase Init
/// Class initialization in Swift is a two-phase process
/// `The first phase`:  each stored property is assigned an initial value by the class that introduced it
/// `The second phase`: each class is given the opportunity to customize its stored properties further before the new instance is considered ready for use

/// The use of a two-phase initialization process makes initialization safe
/// Two-phase initialization prevents property values from being accessed before they’re initialized,
/// and prevents property values from being set to a different value by another initializer unexpectedly

// MARK: Safety Check
/// 1) A designated initializer must ensure that all of the properties introduced by its class are initialized before it delegates up to a superclass initializer

/// 2) A designated initializer must delegate up to a superclass initializer before assigning a value to an inherited property.
///   If it doesn’t, the new value the designated initializer assigns will be overwritten by the superclass as part of its own initialization.

/// 3) A convenience initializer must delegate to another initializer before assigning a value to any property (including properties defined by the same class).
///   If it doesn’t, the new value the convenience initializer assigns will be overwritten by its own class’s designated initializer.

/// 4) An initializer can’t call any instance methods, read the values of any instance properties, or refer to self as a value until after the first phase of initialization is complete.

// MARK: Pahse 1
/// - A designated or convenience initializer is called on a class.
/// - Memory for a new instance of that class is allocated. The memory isn’t yet initialized.
/// - A designated initializer for that class confirms that all stored properties introduced by that class have a value. The memory for these stored properties is now initialized.
/// - The designated initializer hands off to a superclass initializer to perform the same task for its own stored properties.
/// - This continues up the class inheritance chain until the top of the chain is reached.
/// - Once the top of the chain is reached, and the final class in the chain has ensured that all of its stored properties have a value, the instance’s memory is considered to be fully initialized, and phase 1 is complete.

// MARK: Phase 2
/// - Working back down from the top of the chain, each designated initializer in the chain has the option to customize the instance further.
///   Initializers are now able to access self and can modify its properties, call its instance methods, and so on.

/// - Finally, any convenience initializers in the chain have the option to customize the instance and to work with self.


