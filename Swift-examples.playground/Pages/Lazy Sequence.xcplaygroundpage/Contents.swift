import Foundation

func foo1() {
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
}


func foo2() {
    /// Lazy Sequence can capture closure that is passed via map mehtod
    /// then apply algorithm only when element is acessed
    
    /// https://www.avanderlee.com/swift/lazy-collections-arrays/
    /// Lazy collections are similar to a regular collection but change the way how modifiers like `map`, `filter`, and `reduce` are processed.
    /// They haven’t got as much attention as they should as they can be more performant in certain cases
    
    /// A lazy collection postpones calculations until they are actually needed.
    /// This can be beneficial in many different cases and prevent doing unneeded work if elements are never being asked in the end.
    
    /// The following example shows a collection of numbers in which even numbers are doubled.
    /// Without using the lazy keyword, all items would be processed directly upon creation:
    var numbers: [Int] = [1, 2, 3, 6, 9]
    let modifiedNumbers = numbers
        .filter { number in
            print("Even number filter")
            return number % 2 == 0
        }.map { number -> Int in
            print("Doubling the number")
            return number * 2
        }
    print(modifiedNumbers)
}


func foo3() {
    /// As you can see, the doubling of the two even numbers happens after all 5 numbers are filtered.
    
    /// If we would add the lazy keyword to make the array compute modifiers lazily, the outcome would be different:
    var numbers: [Int] = [1, 2, 3, 6, 9]
    let modifiedLazyNumbers = numbers.lazy
        .filter { number in
            print("Lazy Even number filter")
            return number % 2 == 0
        }.map { number -> Int in
            print("Lazy Doubling the number")
            return number * 2
        }
    print(modifiedLazyNumbers)
    
    /// In fact, the modifiers aren’t getting called at all! This is because we didn’t request any of the numbers yet.
    /// Modifiers like filter and map will only be executed upon requesting an element:
    print(modifiedLazyNumbers.first!)
    
    /// You can imagine this can save you from a lot of work if only a few items are used from a big collection.
}

