import Foundation

// Race Condition
// Priority Inversion
// Deadlock
// Livelock
// Starvation
// Data Race


func foo1() { // Data race
    var count = 0
    
    let thread1 = Thread {
        for _ in 0...999 {
            count += 1
        }
    }
    
    let thread2 = Thread {
        for _ in 0...999 {
            count += 1
        }
    }
    
    thread1.start()
    thread2.start()
    
    DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
        print(count)
    }
    
    /// Here count amlost never will be 2000
    /// because `count += 1` is 3 step operation
    /// 1. Read data
    /// 2. Add 1 to the read data
    /// 3. write new value to count
    
    // Race condition
    /// thread1 read data == 0
    /// thread2 read data == 0
    
    /// thread1 add 1 to 0
    /// thread2 add 1 to 0
    
    /// theard1 write 1 to count
    /// theard2 write 1 to count
}

func foo2() { // solution
    var count = 0
    let lock = NSLock()
    
    let thread1 = Thread {
        lock.lock()
        for _ in 0...999 {
            count += 1
        }
        lock.unlock()
    }
    
    let thread2 = Thread {
        lock.lock()
        for _ in 0...999 {
            count += 1
        }
        lock.unlock()
    }
    
    thread1.start()
    thread2.start()
    
    DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
        print(count)
    }
    
}

