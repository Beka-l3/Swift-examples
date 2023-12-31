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
/// ``Operation`` - is high level tool to work with concurrency
/// Main idea is an `abstruction` of a task
/// It also provides access to it's lifecycle
/// The main difference is that an `Operation` is used only once
/// 1 operation = 1 task instance

/// we can add Operation to the OperationQeue
/// or we can execute mannually by calling `start()`
/// might be helpfull if want it to run on the current thread

/// Another great difference if
/// ability to `cancle` operation even if it is running

// MARK: Lifecycle
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

// MARK: Main methods
/// - main()
/// - start()



// MARK: Block Operation
func fii1() {
    let operation = BlockOperation {
        print("Hello, World!")
    }
    
    operation.addExecutionBlock {
        print("Hello, again!")
    }
    
    operation.start()
}

func fii2() {
    let operationQueue = OperationQueue()
    
    let operation = BlockOperation {
        print("Hello, World!")
    }
    
    operationQueue.addOperation(operation)
}


// MARK: Custom classes
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
    
    let calculate = CalculateOperation(a: 2, b: 2)
    calculate.onCalc = { sum in print(sum) }
    
    let observer = OperationObserver(operation: calculate)
    calculate.start()
}


// MARK: Dependencies
/// func addDependency(_ op: Operation)
/// func removeDependency(_ op: Operation)

func foo3() {
    let operation1 = BlockOperation {
        print("Operation 1 is complete")
    }
    
    let operation2 = BlockOperation {
        print("Operation 2 is complete")
    }
    operation2.addDependency(operation1)
    
    let queue = OperationQueue()
    queue.addOperations([operation1, operation2], waitUntilFinished: true)
}



// MARK: completion
func foo4() {
    let operation = BlockOperation {
        // Выполнение операции
    }
    
    operation.completionBlock = {
        // Код, который выполнится после завершения операции
    }
}

func foo5() {
    class CustomOperation: Operation {
        var onCompletion: (() -> Void)?
        
        override func main() {
            // Выполнение операции
            onCompletion?()
        }
    }
    
    let operation = CustomOperation()
    operation.onCompletion = {
        // Действия после завершения операции
    }
    
    let queue = OperationQueue()
    queue.addOperation(operation)
}


// MARK: Timeout
func foo6() {
    let timeoutInterval: TimeInterval = 10
    
    let operation = BlockOperation {
        // Долгая операция
    }
    
    let semaphore = DispatchSemaphore(value: 0)
    
    DispatchQueue.global().async {
        operation.start()
        semaphore.signal()
    }
    
    if semaphore.wait(timeout: .now() + timeoutInterval) == .timedOut {
        operation.cancel()
        print("Operation timed out")
    } else {
        print("Operation completed successfully")
    }
}



// MARK: - Operation Queue

func foo7() {
    class MyOperation: Operation {
        var onCompletion: (() -> Void)?
        
        override func main() {
            // Выполнение операции
            onCompletion?()
        }
    }
    
    let operationQueue = OperationQueue()
    
    let operation = MyOperation()
    
    operationQueue.addOperation(operation)
}


func foo8() { // Dependencies
    class MyOperation: Operation { }
    
    let operationQueue = OperationQueue()
    
    let operation1 = MyOperation()
    
    let operation2 = MyOperation()
    operation2.addDependency(operation1)
    
    operationQueue.addOperation(operation1)
    operationQueue.addOperation(operation2)
    
    // Need to remember to add both operations
    // Adding only operation2 with dependency from operation1
    // does npt guarantee execution of operation1
    // it only effects their order
}


func foo9() { // limit of operations at a time
    let operationQueue = OperationQueue()
    
    operationQueue.maxConcurrentOperationCount = 2
}


func foo10() { // state control
    let operationQueue = OperationQueue()
    
    let operation1 = BlockOperation {
        print("Operation 1 is complete")
    }
    
    let operation2 = BlockOperation {
        print("Operation 2 is complete")
    }
    
    // stop executing operations
    operationQueue.isSuspended = true
    operationQueue.addOperation(operation1)
    operationQueue.addOperation(operation2)
    
    // OperationQueue starts executing only after this line
    operationQueue.isSuspended = false
}

// MARK: Priorities
// queuePriority: .veryLow, .low, .normal, .high, .veryHigh
/// Helps to set priority inside of the specific Queue. Effects Execution order

// qualityOfService: .background, .utility, .default, .userInitiated, .userInteractive
/// Sets general priority in the system. On OS level. Can effect resource management


func foo11() { // Grouping
    let operationQueue = OperationQueue()
    
    let operation1 = BlockOperation {
        print("Operation 1 is complete")
    }
    
    let operation2 = BlockOperation {
        print("Operation 2 is complete")
    }
    
    let groupOperation = BlockOperation {
        print("All operations are complete")
    }
    
    groupOperation.addDependency(operation1)
    groupOperation.addDependency(operation2)
    
    operationQueue.addOperations([operation1, operation2, groupOperation], waitUntilFinished: false)
}


func foo12() { // Cancellation
    let operationQueue = OperationQueue()
    
    let operation1 = BlockOperation {
        print("Operation 1 is complete")
    }
    
    let operation2 = BlockOperation {
        print("Operation 2 is complete")
    }
    operation2.addDependency(operation1)
    
    operationQueue.addOperations([operation1, operation2], waitUntilFinished: false)
    
    // Cancel operation2
    operation2.cancel()
    
    // Check statuses of cancellation for operation1 and operation2
    print("Operation 1 isCancelled: \(operation1.isCancelled)") // false
    print("Operation 2 isCancelled: \(operation2.isCancelled)") // true
}



// MARK: Progress check
/// Class Operation does not provide mechanism for checking the progress
/// We can implement our own progress checker with `Progress`
/// By setting total work amount and handling the counter

func foo13() {
    class MyOperation: Operation {
        
        private let totalWorkUnits: Int64
        @objc dynamic lazy var progress = Progress(totalUnitCount: totalWorkUnits)
        
        init(totalWorkUnits: Int64) {
            self.totalWorkUnits = totalWorkUnits
            super.init()
        }
        
        override func main() {
            
            var completedWorkUnits: Int64 = 0
            
            // Проверка на отмену операции
            if isCancelled {
                return
            }
            
            // Асинхронное выполнение работы
            DispatchQueue.global().async { [weak self] in
                guard let self else { return }
                
                while completedWorkUnits < self.totalWorkUnits {
                    
                    // Проверка на отмену операции
                    if self.isCancelled {
                        return
                    }
                    
                    // Выполнение работы
                    // ...
                    
                    completedWorkUnits += 1
                    self.progress.completedUnitCount = completedWorkUnits
                }
            }
        }
    }
    
    // Создание экземпляров очереди и операции
    let operationQueue = OperationQueue()
    
    let operation = MyOperation(totalWorkUnits: 10)
    
    // Подписка на изменения прогресса
    let progressObserver = operation.progress.observe(\.fractionCompleted) { progress, _ in
        print("Progress: \(progress.fractionCompleted)")
    }
    
    operationQueue.addOperation(operation)
}


// MARK: thread safety
func foo14() { // Dispatch Semaphore
    class SharedResource {
        private var value = 0
        private let accessSemaphore = DispatchSemaphore(value: 1)
      
        func increment() {
            accessSemaphore.wait()
            value += 1
            accessSemaphore.signal()
        }

        func getValue() -> Int {
            defer {
                accessSemaphore.signal()
            }
          
            accessSemaphore.wait()
            return value
        }
    }

    let sharedResource = SharedResource()

    let operation1 = BlockOperation {
        sharedResource.increment()
    }

    let operation2 = BlockOperation {
        let value = sharedResource.getValue()
        print("Value: \(value)")
    }

    let queue = OperationQueue()
    queue.addOperations([operation1, operation2], waitUntilFinished: true)
}
