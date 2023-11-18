import UIKit

// MARK: Grand Central Dispatch (GCD)

/// Concurrency in iOS
/// Main Abstract element in concurrency is ``Queues``
/// Both `GCD` and `Operation` work with ``Queues``

/// `Queue` - First In First Out (FIFO)
/// They execute `Tasks` / `Closures` in `order`.  Tasks might have different priorities

/// `Queue` can be of 2 types
/// `Serial` and `Parallel`

/// `Serail` queue has only one threaad. All tasks executed one by one. Only one task aat a time

/// `Parallel` queue can have multiple threads. Tasks can be separately executed on diferrent threads.
/// It is faster, but can be issues such as
/// - Race Condition
/// - Priority Inversion
/// - DeadLocks    (LiveLocks)

/// Tasks can be passed to the queue in 2 manners
/// ``Sync`` and ``Async``

/// `Sync` - the queue that passes a task to another queue, waits it's completion. Then continues it's own execution
/// `Async` - the queue that passes a task to another queue, does not wait it's completion. After it passes taks, it continues it's own execution

func foo() {
    /// Global Queues:
    /// `Serail`
    /// - `Main`:  All UI operation
    let main = DispatchQueue.main
    
    
    /// `Background` `Concurrent`
    /// - `User Interactive`: Highest priority
    /// For tasks taht interact with user right now and require less time: animations.
    /// Example: when user is dragging on the screen, and need to make some calculations
    let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
    
    /// - `User Initiated`
    /// For tasks that do not need response right now, but need fast as possible.
    /// Might take couplt of seconds
    let userInitiatedQueue = DispatchQueue.global(qos: .userInitiated)
    
    /// - `Utility`
    /// Tasks does not need response back to user
    /// Might take up to minutes
    /// for example, downloading data
    let utilityQueue = DispatchQueue.global(qos: .utility)
    
    /// - `Background`: Lowest priority
    /// tasksk that is not connected to UI and not time critical
    /// for example, backups
    let backgroundQueue = DispatchQueue.global(qos: .background)
    
    /// - `Default`
    /// when there is not information about priority
    /// It might then defined by an operator
    /// prximitely by default it is between `User initiated` and `Utility`
    let defaultQueue = DispatchQueue.global()
}


// Race condition
func foo1() {
    var value = "A"
    
    func changeValue(_ variant: Int) {
        sleep(1)
        value += "+"
        print("\(value) - \(variant)")
    }
    
    let mySerialQueue = DispatchQueue(label: "my.queue")
    
    mySerialQueue.async {   // Potential place for race condition
        changeValue(1)
    }
    
    value
    
    value = "B"
    mySerialQueue.sync {
        changeValue(2)
    }
    value
    
    /// At the end we wanted B+
    /// But we got B++
}


func foo2() {
    var value = "A"
    
    func changeValue(_ variant: Int) {
        sleep(1)
        value += "+"
        print("\(value) - \(variant)")
    }
    
    let mySerialQueue = DispatchQueue(label: "my.queue")
    
    mySerialQueue.sync {        // with sync we got rid of race condition
        changeValue(1)
    }
    
    value
    
    value = "B"
    mySerialQueue.sync {
        changeValue(2)
    }
    value
}


// Priority inversion
/// Example: when high priority taks is waiting for low priority taks to finish
func foo3() {
    func printCucumbers() {
        for _ in 0..<7 {
            print("🥒")
        }
    }
    
    func printTomatos() {
        for _ in 0..<7 {
            print("🍅")
        }
    }
    
    func priorityInversionDemo() {
        let userInteractiveQueue = DispatchQueue(label: "com.demo.userInteractive", qos: .userInteractive)
        let userInitiatedQueue = DispatchQueue(label: "com.demo.userInitiated", qos: .userInitiated)
        let backgroundQueue = DispatchQueue(label: "com.demo.background", qos: .background)
        
        userInteractiveQueue.async {
            backgroundQueue.async {
                printCucumbers()
            }
            
            userInitiatedQueue.async {
                printTomatos()
            }
        }
    }
}

/// there might be `Limited Priority Inversion`
/// When One high task is waiting for one low task and it is clear when it finishes
//
/// Also might be `UnLimited Priority Inversion`
/// When One high task is waiting for one low task
/// but medium tasks keep executing  and low task is waiting them to finish first


// Deadlock
/// when there is a cirlce of waiting queues / tasks
func foo4() {
    let a = DispatchQueue(label: "a.a.a")
    let b = DispatchQueue(label: "b.b.b")
    let c = DispatchQueue(label: "c.c.c")
    
    a.sync {
        print("a")
        
        b.sync {
            print("b")
            
            c.sync {
                print("c")
                
                a.sync {
                    print(a)
                }
            }
        }
    }
}



// MARK: - Experiments
func fii1() {
    let mainQueue = DispatchQueue.main
    
    let userIntreractive = DispatchQueue.global(qos: .userInteractive)
    let userInited = DispatchQueue.global(qos: .userInitiated)
    let utility = DispatchQueue.global(qos: .utility)
    let background = DispatchQueue.global(qos: .background)
    
    let defaultQueue = DispatchQueue.global()
}

