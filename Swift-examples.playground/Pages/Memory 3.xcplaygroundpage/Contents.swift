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
       dispatch_async(dispatch_get_global_queue(0, 0), {
           let _ = holder.weak
       })
       dispatch_async(dispatch_get_global_queue(0, 0), {
           let _ = holder.weak
       })
    }
    
    /// if counter is 1 then both access it at the same time
    /// then both try to reduce counter
    /// but memory can be deallocated only once
}

