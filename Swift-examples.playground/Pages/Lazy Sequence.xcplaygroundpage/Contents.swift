import Foundation


let array = Array(0...100000)

let multArray = array.map { $0 * 2 }

let lazyMultArray = array.lazy.map { $0 * 3 }

let id = 3

print(array[id])
print(multArray[id])
print(lazyMultArray[id])


/// Lazy Sequence can capture closure that is passed via map mehtod
/// then apply algorithm only when element is acessed

