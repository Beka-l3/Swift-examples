import Foundation


// MARK: References
/// - Strong
/// - Unowned
/// - Weak




// MARK: - Before Swift 4
/// Before Swift 4
/// Objects contained 2 counters (Strong, Weak)

/// When `Strong` == 0
/// - then all the data of the object is cleared
/// - but the class is not reallocated, because needed to store `Weak` counter
/// - It becomse `NSZombie`

/// When object is accessed by `Weak` ref and if it is a zombie
/// - counter is decreased

// Issues
/// - Zombie may remain in the memory for a long time
/// - Not multithread safe
func foo1() {
    class Target {}
    
    class WeakHolder {
        weak var weak: Target?
    }
    
    for i in 0..<1000000 {
        print(i)
        let holder = WeakHolder()
        holder.weak = Target()
        
        DispatchQueue.global().async {
            let _ = holder.weak
        }
        
        DispatchQueue.global().async {
            let _ = holder.weak
        }
    }
    
    /// if counter is 1 then both access it at the same time
    /// then both try to reduce counter
    /// but memory can be deallocated only once
}
// MARK: - After Swift 4





// MARK: Side Table
/// Usually object does not have weak reference
/// So to allocated a memory for counter for every object is not effective

/// While there is no `Weak` ref
/// Object stores a ``pointer``
/// `Strong` and `Unowned` counters

/// If there is a `Weak` ref - `Side Table` is created
/// Objects stores a ``pointer``
/// Reference to the `Side Table`

/// Side table stores a ``pointer``
/// Ref to the object
/// `Strong`, `Unowned`, and `Weak` counters

/// `Weak` reference `do` `not` point straight to the object
/// Instead, they point ot the `Side Table` of the object
/// And `Side Table` has an `direct` ref to the object

/// Also, Side Tables can be created if a number is greater than `Int` can store

// This solves 2 issues mentioned above
/// - Memory deallocation right after `Strong` counter == 0
/// - Safely deallocate `Weak` counter





// MARK: - Lifecycle

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
