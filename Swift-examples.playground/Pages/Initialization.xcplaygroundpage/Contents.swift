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



