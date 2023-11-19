import UIKit
import PlaygroundSupport

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

let mainQueue = DispatchQueue.main

let userIntreractiveQueue = DispatchQueue.global(qos: .userInteractive)
let userInitedQueue = DispatchQueue.global(qos: .userInitiated)
let utilityQueue = DispatchQueue.global(qos: .utility)
let backgroundQueue = DispatchQueue.global(qos: .background)

let defaultQueue = DispatchQueue.global()


func task(_ symbol: String) {
    for i in 0...9 {
        print("\(symbol) \(i) priority: \(qos_class_self().rawValue)")
    }
}

func taskHigh(_ symbol: String) {
        print("\(symbol) high priority: \(qos_class_self().rawValue)")
}



func fii1() {
    print("---------------------------")
    print("sync")
    print("global: .concurrent   queue: .userInitiated")
    print("---------------------------")
    
    userInitedQueue.sync {
        task("😂")
    }
    task("🥶")
    
    /// here the second task starts after the first finishes
    /// and here priority is not important
    /// as an optimizztion, both tasks might be executed on the same thread
}
//fii1()


func fii2() {
    print("---------------------------")
    print("async")
    print("global: .concurrent   queue: .userInitiated")
    print("---------------------------")
    
    userInitedQueue.async {
        task("😂")
    }
    userIntreractiveQueue.async {
        task("🤬")
    }
    task("🥶")
    
    /// here tasks do not wait each other to start
    /// seams like playground queue has the same priority as `.userInteractive`
    /// even if it is the last in the queue, it goes before `.userInitiated`
}
//fii2()


func fii3() {
    print("---------------------------")
    print("sync")
    print("private: .serial   queue: -")
    print("---------------------------")
    
    let mySerialQueue = DispatchQueue(label: "com.example.serial")
    
    mySerialQueue.sync {
        task("😂")
    }
    task("🥶")
    
    /// the same as before
    /// playground queue waits `mySerialQueue` queue to finish
}

func fii4() {
    print("---------------------------")
    print("async")
    print("private: .serial   queue: -")
    print("---------------------------")
    
    let mySerialQueue = DispatchQueue(label: "com.example.serial")
    
    mySerialQueue.async {
        task("😂")
    }
    task("🥶")
    
    /// even if mySerialQueue is serial, we see the same as before
    /// because these tasks are on a different queue and thread
}
//fii4()

func fii5() {
    print("---------------------------")
    print("async")
    print("private: .serial   queue: -")
    print("---------------------------")
    
    let mySerialQueue = DispatchQueue(label: "com.example.serial")
    
    mySerialQueue.async {
        task("😂")
    }
    mySerialQueue.async {
        task("🤢")
    }
    task("🥶")
    
    /// but if we add 2 tasks to the `mySerialQueue`
    /// the second task will wait the first tasks to finish on that queue
    /// and task from `playground` queue executes asynchoniosly from them
}


func fii6() {
    let mySerialQueue1 = DispatchQueue(label: "com.example.serial1", qos: .utility)
    let mySerialQueue2 = DispatchQueue(label: "com.example.serial2", qos: .background)
    
    mySerialQueue2.async {
        task("😂")
    }
    mySerialQueue1.async {
        task("🤢")
    }
}



func fii7() {
    let myConcurrentQueue = DispatchQueue(label: "com.example.serial", qos: .userInteractive, attributes: .concurrent)
    
    myConcurrentQueue.async {
        task("😂")
    }
    myConcurrentQueue.async {
        task("🤢")
    }
    task("🥶")
    
    /// now all of them are running in parallel
}
//fii7()



func fii8() {
    let myWorker1 = DispatchQueue(
        label: "com.example.concurrent",
        qos: .userInitiated,
        attributes: [.concurrent, .initiallyInactive]
    )
    
    myWorker1.async {
        task("😂")
    }
    myWorker1.async {
        task("🤢")
    }
    task("🥶")
    myWorker1.activate()
    /// initially custom queue is inactive
    /// we can add tasks
    /// then give command to start
}
//fii8()



func fii9() {
    let workItem = DispatchWorkItem(qos: .userInteractive, flags: [.enforceQoS]) {
        taskHigh("🫥")
    }
    
    let myConcurrentQueue1 = DispatchQueue(label: "com.example.serial1", qos: .userInitiated, attributes: .concurrent)
    let myConcurrentQueue2 = DispatchQueue(label: "com.example.serial2", qos: .background, attributes: .concurrent)
    
    myConcurrentQueue1.async { task("😂") }
    myConcurrentQueue2.async { task("🤢") }
    
    myConcurrentQueue2.async(execute: workItem)
    myConcurrentQueue1.async(execute: workItem)
 
    /// we can interrupt queues with `workItems` and have moew control over tasks
    /// flog `.enforceQoS` forces to high priority execution
    /// might help from `priority inversion`
}
//fii9()



func fii10() {
    /// GCD cannot stop tasks after it started
    /// but can remove tasks from the queue before it started
    /// But we can user `workItem.notify(queue: execute: )`
    
    let view = UIView(frame: .init(origin: .zero, size: .init(width: 600, height: 600)))
    
    let imageView = UIImageView(frame: .init(origin: .zero, size: .init(width: 600, height: 600)))
    imageView.backgroundColor = .systemPurple
    imageView.contentMode = .scaleAspectFit
    view.addSubview(imageView)
    
    PlaygroundPage.current.liveView = view
    
    
    let imageUrl = URL(string: "https://images.unsplash.com/photo-1623491527126-8ccdf066feef?q=80&w=3072&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
    
    var data: Data?
    let queue = DispatchQueue.global(qos: .utility)
    
    let workItem = DispatchWorkItem {
        data = try? Data(contentsOf: imageUrl!)
    }
    
//    workItem.cancel()
    queue.async(execute: workItem)
    
    /// Wait workItem to finish
    /// then execute another tasks on .main queue
    /// to update image
    workItem.notify(queue: .main) {
        if let imageData = data {
            imageView.image = UIImage(data: imageData)
        }
    }
}
//fii10()



func fii11() {
    // image load methods
    let view = UIView(frame: .init(origin: .zero, size: .init(width: 600, height: 600)))
    
    let imageView = UIImageView(frame: .init(origin: .zero, size: .init(width: 600, height: 600)))
    imageView.backgroundColor = .systemPurple
    imageView.contentMode = .scaleAspectFit
    view.addSubview(imageView)
    
    PlaygroundPage.current.liveView = view
    
    let imageUrl = URL(string: "https://images.unsplash.com/photo-1623491527126-8ccdf066feef?q=80&w=3072&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")!
    
    
    func fetch1() { // classic
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            if let imageData = try? Data(contentsOf: imageUrl) {
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    func fetch2() { // async tasks from URLSession
        let task = URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            if let imageData = data {
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: imageData)
                }
            }
        }
        task.resume()
    }
    
    func fetch3() { /// with work Item
        var data: Data?
        let queue = DispatchQueue.global(qos: .utility)
        let workItem = DispatchWorkItem {
            data = try? Data(contentsOf: imageUrl)
        }
        
        queue.async(execute: workItem)
        workItem.notify(queue: .main) {
            if let imageData = data {
                imageView.image = UIImage(data: imageData)
            }
        }
    }
}


