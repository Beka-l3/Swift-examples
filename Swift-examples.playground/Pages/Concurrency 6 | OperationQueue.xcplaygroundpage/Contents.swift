import Foundation


/// ``Operation`` and ``OperationQueue``

/// ``Operation`` is an abstract class.
/// `BlockOperation` is provided implementation of the class by Apple
/// In most cases this is enough to make some async tasks
/// You can create your own implementation for a specific case.

/// ``OperationQueue`` is a Queue that will handle all the operation
/// multithreading is handled by it
/// It can be one for all the operations
/// It uses GCD under the hood




// MARK: - Operation
/// ``Operation`` - is high level toll to work with concurrency
/// Main idea is an `abstruction` of a task
/// It also provides access to it's lifecycle
/// The main difference is that an `Operation` is used only once
/// 1 operation = 1 task instance

/// we can add Operation to the OperationQeue
/// or we can execute mannually by calling `start()`
/// might be helpfull if want it to run on the current thread

/// Another great difference if
/// ability to `cancle` operation even if it is running

// Lifecycle
/// - `Pending`: not in the queue. Wating for dependencies or planned to be put in a queue. Can be cancelled
/// - `Ready`:  Put in a queue. Can be cancelled
/// - `Executing`: Running. Can be cancelled
/// - `Finished`: Finished
/// - `Cancelled`: Was cancelled or deleted
// Var
/// - isReady
/// - isAsynchronous
/// - isExecuting
/// - isFinished
/// - isCancelled

// Main methods
/// - main()
/// - start()

func foo1() {
    final class CalculateOperation: Operation {
        private let a: Int
        private let b: Int
        var onCalc: ((_ sum: Int) -> Void)?
        
        init(a: Int, b: Int) {
            self.a = a
            self.b = b
        }
        
        override func main() {
            onCalc?(a + b)
        }
    }
    
    let calculate = CalculateOperation(a: 2, b: 2)
    
    calculate.onCalc = { sum in print(sum) }
    calculate.start()
}

func foo2() {
    final class CalculateOperation: Operation {
        private let a: Int
        private let b: Int
        var onCalc: ((_ sum: Int) -> Void)?
        
        private var _isFinished: Bool = false
        private var _isExecuting: Bool = false
        
        private let queue = DispatchQueue(label: "calculate-operation.serial-queue")
        
        override var isFinished: Bool { _isFinished }
        override var isExecuting: Bool { _isExecuting }
        override var isAsynchronous: Bool { true }
        
        init(a: Int, b: Int) {
            self.a = a
            self.b = b
        }
        
        override func main() {
            onCalc?(a + b)
            
            _isExecuting = false
            _isFinished = true
        }
        
        override func start() {
            _isExecuting = true
            
            queue.async { self.main() }
        }
        
        /// example with KVO
        //        override func main() {
        //            onCalc?(a + b)
        //
        //            willChangeValue(forKey: "isExecuting")
        //            _isExecuting = false
        //            didChangeValue(forKey: "isExecuting")
        //
        //            willChangeValue(forKey: "isFinished")
        //            _isFinished = true
        //            didChangeValue(forKey: "isFinished")
        //        }
        //
        //        override func start() {
        //            willChangeValue(forKey: "isExecuting")
        //            _isExecuting = true
        //            didChangeValue(forKey: "isExecuting")
        //
        //            queue.async { self.main() }
        //        }
        
    }
    
    // Описываем класс Observer, который сообщит нам текущее состояние переданной операции
    final class OperationObserver: NSObject {
        // Описываем перечисление, которое будет определять состояние операции
        enum OperationState: String, CaseIterable {
            case asynchronous = "isAsynchronous"
            case ready = "isReady"
            case executing = "isExecuting"
            case finished = "isFinished"
            case cancelled = "isCancelled"
        }
        
        private let operation: Operation
        
        init(operation: Operation) {
            self.operation = operation
            super.init()
            
            // Подписываемся на изменения, используя KVO
            func observe() {
                OperationState
                    .allCases
                    .forEach {
                        operation.addObserver(
                            self,
                            forKeyPath: $0.rawValue,
                            options: .initial,
                            context: nil
                        )
                    }
            }
            
            observe()
        }
        
        // Обрабатываем изменение состояния оперции. В нашем лучае выводим в консоль текущее значение свойства.
        override func observeValue(
            forKeyPath keyPath: String?,
            of object: Any?,
            change: [NSKeyValueChangeKey : Any]?,
            context: UnsafeMutableRawPointer?)
        {
            guard
                let keyPath = keyPath,
                let operationState = OperationState(rawValue: keyPath)
            else { return }
            
            func printOperationState(_ stateValue: Bool) { print("\(operationState.rawValue): \(stateValue)") }
            
            switch operationState {
            case .asynchronous: printOperationState(operation.isAsynchronous)
            case .ready:        printOperationState(operation.isReady)
            case .executing:    printOperationState(operation.isExecuting)
            case .finished:     printOperationState(operation.isFinished)
            case .cancelled:    printOperationState(operation.isCancelled)
            }
        }
        
    }
}
