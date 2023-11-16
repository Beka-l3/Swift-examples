import Foundation

/// RAM - memory
/// store the programm, variables, data structures

/// RAM has two kind of parts of memory to store
/// ``Stack``  and  ``Heap``


/// ``Stack`` - Fast. Memory allocation is calculated during `compilation`
/// - It is for static memory menagement. It works using `LIFO`(last in - first out) principle.
/// - All the operations are happen only to the top object.
/// - Limit: size of the object must be calculatable and static. It must be calculated during compilation.
/// - Each `thread` of multithread / concurrent programm has it's own ``stack``
/// - When `function` is called, all local properties are stored in ``stack``. When function returns properties are removed.
/// - If the size of `value` type is defined during compilation, and does not has recursive reference, and not located in `reference` type
///       then it is stored in ``stack``


/// ``Heap`` - Slow. It is used for dynamic memory management. Objects are stored with `header` inorder to find them.
/// - Operations on ``heap`` heppen slower, because there is extra step to find the object
/// - Objects that have dynamic size, for example array, are stored in ``heap``. Any amount of elements can be added to the array
/// - ``Heap`` is `common` for all `threads`
/// - Since ``heap`` is not trivial in memory management, the most of the memory issues are with ``heap``
///      Different programming languages provide their ways to resolve issues


// Memory management MM ways:
/// - Mannual
/// - Garbage Collector (GC)
///   -- Pointer based GC
///   -- Reference counter based GC
/// - Automatic Reference Counter


// Manual
/// Programming language does not provide automatic MM. Everything is done by a developer.
/// Memory allocation, deallocation, reallocation, and free is left for the developer. For example: C


// Garbage Collector
/// Predefined intervals are chosen, then garbages collector looks for memory places that are not used then remove them.
/// However, this process can be executed during heavy proccing which leads slow performance.
/// For example: JVM, JavaScript, Python, C#, GoLang, Ruby


// Automatic Reference Counter
/// This is similar to GC with reference counting.
/// But instead if starting counting references at predefined time intervals
/// reference counting happens during compilation
/// Memory allocation, reallocation, deallocation, and free code are insrted into code bytes.
/// When Refernce Count == 0, then memory is freed as a it is part of the written code.
//
/// ARC does not support Recursive reference cycles. To handle this extra key words are used.


// Value & Reference types
/// ``Value type`` - each variable has it's own copy of the data and operation on one of the does not affect others. `Stack` representative
//
/// ``Reference type`` - We have reference, that points to the place in memory. Variables of reference type can point the same place in memory.
/// Hence, operation on one variable can affect other variables. `Heap` representative

/// `Value` - Struct, Enum, Int, Double, String, Set, Tuple, Array, Dictionary
/// `Reference` - Class, Function, Closure, Actor

/// Main mesurements to compare `Structs` and `Classes`:
/// - Copying price
/// - Allocation and Deallocation price
/// - Rerence counting price


// Memory - list of bytes. Bytes are ordered. Each byte has it's address.
/// Descrete period of address is called `Adress Space`
/// `Address Space` in iOS app has 4 segments:
/// `Text` - Machine code of executable instructions.
/// `Data` - Static variables of Swift: methadata, global variables etc.
/// `Stack` - Temporary variables
/// `Heap` - objects that has lifetime






