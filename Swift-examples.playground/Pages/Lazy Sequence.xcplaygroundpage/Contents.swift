import Foundation

/// Lazy sequences are regular sequences where each item is computed on demand rather than up front.
/// For example, consider this array of numbers:
let array = Array(0...100000)

/// That will hold 100,000 numbers. Now, if we wanted to double all those numbers, we’d write something like this:
let multArray = array.map { $0 * 2 }

/// That will cause Swift to double all 100,000 numbers, and sometimes that’s exactly what you want.
/// However, if you know you intend to use only a handful of them, you can make the calculation lazy instead, like this:
let lazyMultArray = array.lazy.map { $0 * 3 }

/// Now that map() call won’t do any work up front
/// it just stores the original array (numbers 1 to 100,000) alongside the transformation closure (tiple each number).
/// So, when you request item 5,000 it can calculate just that one for you and return it in a split second – a significant time saving
let id = 5000

print(array[id])
print(multArray[id])
print(lazyMultArray[id])


/// Lazy Sequence can capture closure that is passed via map mehtod
/// then apply algorithm only when element is acessed

/// https://www.avanderlee.com/swift/lazy-collections-arrays/
/// Lazy collections are similar to a regular collection but change the way how modifiers like `map`, `filter`, and `reduce` are processed.
/// They haven’t got as much attention as they should as they can be more performant in certain cases
