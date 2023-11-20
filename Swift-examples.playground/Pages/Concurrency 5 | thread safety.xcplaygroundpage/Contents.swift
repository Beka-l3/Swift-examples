import UIKit
import Foundation



func foo1() {
    var usualString = ""
    
    for i in 0...9 {
        DispatchQueue.global().async {
            usualString += "🙃"
            print("\(i) priority: \(qos_class_self().rawValue)")
        }
    }
    
    for i in 0...9 {
        usualString += "🥶"
        print("\(i) priority: \(qos_class_self().rawValue)")
    }
    
    print(usualString)
}




// MARK: - Dispatch Barrier

/// when 2 thread try to write the same memory place
/// it my call damage (dirt) the memory

/// to make it safe operation
/// we need to controll, how data is `read / write`

/// `read`: must be sync and cuncurrent
/// `write`: must be async and must be single tasks to work with the data at the moment

/// `Dispatch Barrier`
/// helps to implement those conditions

/// When task with `.barrier` flagg is added to the queue
/// it is not started immidietly
/// first, it waits all other tasks to finish
/// then it executes
/// and it does not allow other tasks in the queue to start
/// while it is working
final class ThreadSafeString {
    private let aQueue = DispatchQueue(label: "com.my.queue", attributes: .concurrent)
    
    private var sentence = ""
    var text: String {
        get {
            var result = ""
            aQueue.sync {
                /// since `aQueue` is `.concurrent`
                /// multiple read operation can happen at the same time
                result = sentence
                
                /// when this tasks is put into queue
                /// if there are `barrier` task is being executed
                /// then it first waits it to finish
                /// only then it get the result
            }
            return result
        }
    }
    
    init(_ value: String) {
        aQueue.async(flags: .barrier) {
            self.sentence = value
        }
    }
    
    
    func addWord(_ word: String) {
        aQueue.async(flags: .barrier) {
            //            if !self.sentence.isEmpty {
            //                self.sentence += " "
            //            }
            
            self.sentence += word
        }
    }
    
    func setString(_ newValue: String) {
        aQueue.async(flags: .barrier) {
            self.sentence = newValue
        }
    }
    
}



func foo2() {
    var usualString = ""
    var safeString = ThreadSafeString("")
    
    func task(symbol: String) {
        for i in 0...9 {
            usualString += symbol
            safeString.addWord(symbol)
            print("\(i)  \(symbol)  priority: \(qos_class_self().rawValue)")
        }
    }
    
    DispatchQueue.global(qos: .userInitiated).async {
        task(symbol: "😇")
    }
    task(symbol: "🥶")
    
    sleep(1)
    
    print("not safe: \(usualString)")
    print("    safe: \(safeString.text)")
}

//foo2()


/// `Thread Sanitizer` in `.xcodeproject` can help to detect `Race Conditions`
/// It is located in `Scheme`
/// It Works when an application is running




// MARK: - Semaphores

/// DispatchSemaphore gives us the ability to control access to a shared resource by multiple threads
/// DispatchSemaphore allows only one thread to access shared resources at a time.
/// And the order of uses of resources is (FIFO), who asks first get the resource first.
/// Semaphores contain threads queues and a counter value integer type

/// `Thread queue`: it is used to keep track of waiting threads in the queue in FIFO order

/// `Counter Value:` it is used to decide if a thread should get access to a shared resource or not.
/// The counter value changes when we call `signal()` or `wait()` function

/// wait() : This function calls each time before using the shared resource. the thread asks the semaphore if the shared resource is available or not. If not, the thread will wait.
/// - wait() function decrease semaphore counter by 1.
/// - If the result value is less than 0, the thread is frozen.
/// - If the result value is equal to or bigger than zero, the code will get executed without waiting

/// signal() : every time after using the shared resource. the function will signal the semaphore that threads are done interacting with the shared resource.
/// - signal() function increase semaphore counter by 1.
/// - If the previous result value was less than zero, this function wakes the oldest thread currently waiting in the thread queue.
/// - If the previous result value is equal to or bigger than zero, it means the thread queue is empty, no one is waiting.

func foo3() {
    /// Firstly, we create a concurrent queue. this queue will be used for executing our movie downloading blocks of code.
    let queue = DispatchQueue(label: "com.gcd.Queue", attributes: .concurrent)
    
    /// Secondly, we create a semaphore, we decided to download 3 movies at a time so we set the semaphore with an initial counter value of 3
    let semaphore = DispatchSemaphore(value: 3)
    
    /// Third, we iterate 12 times using a for loop. On each iteration we do the following: wait() → download movie → signal()
    for i in 0..<12 {
        queue.async {
            let movieNumber = i + 1
            
            semaphore.wait()
            print("Downloading movie", movieNumber)
            
            sleep(2)
            
            print("Downloaded movie", movieNumber)
            semaphore.signal()
        }
    }
}
//foo3()


func foo4() {
    let queue = DispatchQueue(label: "com.gcd.Queue", attributes: .concurrent)
    let semaphore = DispatchSemaphore(value: 3)
    var movies: [Int] = []
    
    for i in 0..<12 {
        queue.async {
            let movieNumber = i + 1
            
            semaphore.wait()
            print("Downloading movie", movieNumber)
            
//            sleep(.random(in: 1...3))
            sleep(1)
            
            print("Downloaded movie", movieNumber)
            movies.append(movieNumber)
            
            semaphore.signal()
        }
    }
    
    queue.asyncAfter(deadline: .now() + 5) {
        print(movies)
    }
}
foo4()




/// This tool helps us to controll amount threads that can refer to our queue at a moment
/// Methods `signal() / wait()` `increment / decrement` the counter
/// Queue is open when `counter` is equal to the value that is passed in `init()`

func foo5() {
    let serialQueue = DispatchQueue(label: "ru.denisegaluev.serial-queue")
    
    // Create semaphore
    let semaphore = DispatchSemaphore(value: 0)
    
    // Sleep serialQueue for 5 sec, after call method signal
    serialQueue.async {
        sleep(5)
        
        // Unlock semaphore
        semaphore.signal()
    }
    
    // block queue
    semaphore.wait()
}

