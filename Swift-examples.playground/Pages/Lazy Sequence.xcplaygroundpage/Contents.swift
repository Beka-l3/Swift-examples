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


func foo4() {
    /// Another benefit of lazy collections is the option to handle output values on the go.
    /// For example, imagine having an avatar image fetcher that you want to use to fetch avatars for usernames starting with the letter A.
    
    let usernames = ["Antoine", "Maaike", "Jaap", "Amber", "Lady", "Angie"]
    usernames
        .filter { username in
            print("filtered name")
            return username.lowercased().first == "a"
        }.forEach { username in
            print("Fetch avatar for (username)")
        }
    /*
      Prints:
      filtered name
      filtered name
      filtered name
      filtered name
      filtered name
      filtered name
      Fetch avatar for Antoine
      Fetch avatar for Amber
      Fetch avatar for Angie
      */
    
    /// All names are filtered first, after which we fetch an avatar for all names starting with an A.
    
    /// Although this works, we would only start fetching after the whole collection is filtered.
    /// This can be a downside if we have to iterate over a big collection of names.

    /// Instead, if we would use a lazy collection in this scenario, we would be able to start fetching avatars on the go:
    let usernames = ["Antoine", "Maaike", "Jaap", "Amber", "Lady", "Angie"]
    usernames.lazy
        .filter { username in
            print("filtered name")
            return username.lowercased().first == "a"
        }.forEach { username in
            print("Fetch avatar for (username)")
        }
    /*
     Prints:
     filtered name
     Fetch avatar for Antoine
     filtered name
     filtered name
     filtered name
     Fetch avatar for Amber
     filtered name
     filtered name
     Fetch avatar for Angie
     */
    
    /// It’s important to understand the differences between a lazy array and a regular array.
    /// Once you know when modifiers are executed, you can decide whether or not a lazy collection makes sense for your specific case
}


func foo5() {
    /// Now that you’ve seen that lazy collections can be more performant,
    /// you might be thinking: “I’ll just use lazy everywhere!”.
    /// However, it’s important to understand the implications of using a lazy array.
    
    /// **Do not over optimize**
    /// A collection having only 5 items won’t give you a lot of performance wins when using lazy.
    /// It’s a case-per-case decision, and it also depends on the amount of work done by your modifiers.
    /// In most cases, lazy will only be useful when you’re only going to use a few items of a large collection.
    
    /// On top of that, it’s important to know that lazy arrays aren’t cached.
    
    /// **Lazy Collections do not cache**
    /// A lazy collection postpones executing modifiers until they’re requested.
    /// This also means that the outcome values aren’t stored in an output array.
    /// In fact, all modifiers are executed again on each item request
    let modifiedLazyNumbers = numbers.lazy
        .filter { number in
            print("Lazy Even number filter")
            return number % 2 == 0
        }.map { number -> Int in
            print("Lazy Doubling the number")
            return number * 2
        }
    print(modifiedLazyNumbers.first!)
    print(modifiedLazyNumbers.first!)
    /*
     Prints:
     Lazy Even number filter
     Lazy Even number filter
     Lazy Doubling the number
     4
     Lazy Even number filter
     Lazy Even number filter
     Lazy Doubling the number
     4
     */
    
    /// While the same scenario with a non-lazy collection would compute output values only once:
    let modifiedNumbers = numbers
         .filter { number in
             print("Lazy Even number filter")
             return number % 2 == 0
         }.map { number -> Int in
             print("Lazy Doubling the number")
             return number * 2
         }
     print(modifiedNumbers.first!)
     print(modifiedNumbers.first!)
     /*
      Prints:
      Lazy Even number filter
      Lazy Even number filter
      Lazy Even number filter
      Lazy Even number filter
      Lazy Even number filter
      Lazy Doubling the number
      Lazy Doubling the number
      4
      4
      */
    
}
