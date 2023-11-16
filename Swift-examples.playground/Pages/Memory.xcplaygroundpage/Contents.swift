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


// Exceptions
/// `Reference type in Stack`
/// - Swift Compiler can store RT in stack if it's size is static and lifetime can be calculated during compilation
///  -- this optimization happens while generating SIL (Swift Intermediate Language)
//
/// `Value type in Heap`
/// - Conform to a protocol and it's size is larger than 3 machine words.
/// - Mixing reference type and value type
///   -- Usually reference to a class is in the struct. And struct is the property of the class.
/// - Value type with Generics
/// - Escaping Closure
/// - Inout argument

/// ``Copy on write``
/// `Collections` defined by the standard library like arrays, dictionaries, and strings
/// use an optimization to reduce the performance cost of copying.
/// Instead of making a copy immediately,
/// these collections share the memory where the elements are stored between the original instance and any copies.
/// If one of the copies of the collection is modified, the elements are copied just before the modification.
/// The behavior you see in your code is always as if a copy took place immediately.


// iOS has Manual (alloc, retain, release, dealloc) and Automatic RC
/// ARC works during `compilation`. And reference counting happens during `runtime`
/// Release / Retain are not callable. Dealloc works partially
/// Property Modificators `Weak`(~ retain) and `Unowned`(~ assign)
//
/// Issue - `Retain Cycle`
/// Issue - during init self is not available before creation


// Side Tables
/// To implement weak references mecahnism
/// <Usually object does not have weak reference> - not neceseraly true
/// <So to allocated a memory for counter for every object is not effective> - not neceseraly true
/// This infomation is stored outside of the object. And is used when needed.
/// When weak reference is first created, memory in side table is allocated.
/// Now, instead of `strong` reference counter, we have a reference to a side table.
/// And side table has a reference to the object
//
/// Side table = counter of references and pointer to the object
/// They are declared during runtime

// Example:
//class HeapObjectSideTableEntry {
//  std::atomic<HeapObject*> object;
//  SideTableRefCounts refCounts;
//  // Operations to increment and decrement reference counts
//}


// Object lifecycle

///                        no weak ref
///                   - - - - - - - - -
///                   |                                    |
///                   |                                    |
///                   |                                    ˇ
/// Live ---> Deiniting ---> Deinited ---> Freed ---> Dead
///         |                                                         ^
///         |                                                          |
///         |                                                          |
///         - - - - - - - - - - - - - -
///           No weak ref, nore unowned ref










