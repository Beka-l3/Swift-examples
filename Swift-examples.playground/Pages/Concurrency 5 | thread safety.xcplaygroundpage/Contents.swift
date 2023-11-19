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
            if !self.sentence.isEmpty {
                self.sentence += " "
            }
            
            self.sentence += word
        }
    }
    
    func setString(_ newValue: String) {
        aQueue.async(flags: .barrier) {
            self.sentence = newValue
        }
    }
    
}




