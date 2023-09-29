import Foundation
import UIKit

/// Swift’s `language-level` support for concurrency in code that needs to be concurrent means Swift can help you catch problems at `compile time`

/// If you’ve written concurrent code before, you might be used to working with `threads`.
/// The concurrency model in Swift is built `on top of threads`, but you don’t interact with them directly.
/// An asynchronous function in Swift can give up the thread that it’s running on,
/// which lets another asynchronous function run on that thread while the first function is blocked.
/// When an asynchronous function resumes, Swift doesn’t make any guarantee about which thread that function will run on

/// An asynchronous function or asynchronous method is a special kind of function or method that can be `suspended` while it’s partway through execution.
/// This is in contrast to ordinary, synchronous functions and methods, which either run to completion, `throw` an `error`, or `never return`.
/// An asynchronous function or method still does one of those three things, but it can also `pause` in the middle when it’s waiting for something.
/// Inside the body of an asynchronous function or method, you mark each of these places where execution can be suspended.

/// The possible suspension points in your code marked with `await` indicate that the current piece of code might pause execution while
/// waiting for the asynchronous function or method to return.
/// This is also called `yielding the thread` because, behind the scenes,
/// Swift suspends the execution of your code on the `current thread` and runs some other code on that thread instead.
/// Because code with `await` needs to be able to suspend execution, only certain places in your program can call asynchronous functions or methods:
/// - Code in the body of an `asynchronous` function, method, or property
/// - Code in the `static main()` method of a structure, class, or enumeration that’s marked with `@main`.
/// - Code in an unstructured child task, as shown in Unstructured Concurrency below.

/// The ``Task.sleep(until:tolerance:clock:)`` method is useful when writing simple code to learn how concurrency works.
/// This method does nothing, but waits at least the given number of nanoseconds before it returns.

func listPhotos(inGallery name: String) async -> [String] {
    print("Fetching list of photos\n")
    do {
        try await Task.sleep(until: .now + .seconds(2), clock: .continuous)
    } catch {
        print("something went wrong")
    }
    
    print("Returning list of photos\n")
    return ["IMG001", "IMG99", "IMG0404"]
}

func foo() {
    print("Hopa")
    
    Task {
        print( await listPhotos(inGallery: "") )
    }
}

//Task { await foo() }


// MARK: - Asyn Sequence
/// The` listPhotos(inGallery:)` function in the previous section asynchronously returns the whole array at once,
/// after all of the array’s elements are ready. Another approach is to wait for one element of the collection at a time using an asynchronous sequence.
///  Here’s what iterating over an asynchronous sequence looks like:

func readFile() async throws {
    let handle = FileHandle.standardInput
    for try await line in handle.bytes.lines {
        print(line)
    }
}

/// Instead of using an ordinary `for-in loop`, the example above writes for with await after it.
/// Like when you call an asynchronous function or method, writing await indicates a possible suspension point.
/// A `for-await-in loop` potentially suspends execution at the beginning of each iteration, when it’s waiting for the next element to be available.

/// In the same way that you can use your own types in a `for-in loop` by adding conformance to the `Sequence` protocol,
/// you can use your own types in a `for-await-in loop` by adding conformance to the ``AsyncSequence`` protocol


// MARK: - Calling Asyn funcs in Parallel
/// Calling an asynchronous function with await runs only one piece of code at a time.
/// While the asynchronous code is running, the caller waits for that code to finish before moving on to run the next line of code.
/// For example, to fetch the first three photos from a gallery, you could await three calls to the `downloadPhoto(named:)` function as follows
func show(_ arr: [String]) {
    for i in arr {
        print(i)
    }
    print()
}

func downloadPhoto(named: String) async -> String {
    print("Fetching \(named)\n")
    do {
        try await Task.sleep(until: .now + .seconds(.random(in: 1...3)), clock: .continuous)
    } catch {
        print("Something went wrong")
    }
    print("Returning \(named)\n")
    return named
}

func foo1() async {
    let photoNames = ["one", "two", "three"]
    
    let firstPhoto = await downloadPhoto(named: photoNames[0])
    let secondPhoto = await downloadPhoto(named: photoNames[1])
    let thirdPhoto = await downloadPhoto(named: photoNames[2])

    let photos = [firstPhoto, secondPhoto, thirdPhoto]
    show(photos)
}

//Task { await foo1() }


/// This approach has an important drawback: Although the download is asynchronous and lets other work happen while it progresses,
/// only one call to `downloadPhoto(named:) `runs at a time.
/// Each photo downloads completely before the next one starts downloading.
/// However, there’s no need for these operations to wait — each photo can download `independently`, or even at the same time

/// To call an asynchronous function and let it run in `parallel` with code around it,
/// write `async` in front of `let` when you define a constant, and then write `await` each time you use the constant.

func foo2() async {
    let photoNames = ["four", "five", "six"]
    
    async let firstPhoto = downloadPhoto(named: photoNames[0])
    async let secondPhoto = downloadPhoto(named: photoNames[1])
    async let thirdPhoto = downloadPhoto(named: photoNames[2])

    let photos = await [firstPhoto, secondPhoto, thirdPhoto]
    show(photos)
}

//Task { await foo2() }

/// In this example, all three calls to downloadPhoto(named:) start without waiting for the previous one to complete.
/// If there are enough system resources available, they can run at the same time.
/// None of these function calls are marked with await because the code doesn’t suspend to wait for the function’s result.

/// Instead, execution continues until the line where photos is defined — at that point,
/// the program needs the results from these asynchronous calls, so you write await to pause execution until all three photos finish downloading


// MARK: - Task and TaskGroup
/// A `task` is a unit of work that can be run `asynchronously` as part of your program
/// `All` asynchronous code runs as part of some `task`.
/// The `async-let` syntax described in the previous section creates a `child task` for you.
/// You can also create a` task group` and add child tasks to that group, which gives you more control over `priority` and `cancellation`,
/// and lets you create a `dynamic` number of tasks

/// Tasks are arranged in a hierarchy. Each task in a task group has the same parent task, and each task can have child tasks
/// Because of the explicit relationship between tasks and task groups, this approach is called ``structured concurrency``

/// Although you take on some of the responsibility for `correctness`,
/// the explicit parent-child relationships between tasks let Swift handle some behaviors like propagating cancellation for you,
/// and lets Swift detect some errors at compile time

func foo3() async {
    await withTaskGroup(of: String.self) { taskGroup in
        print("Start of task group\n")
        let photoNames = await listPhotos(inGallery: "Summer Vacation")
        for name in photoNames {
            taskGroup.addTask { await downloadPhoto(named: name) }
        }
        print("End of task group\n")
    }
}

//Task { await foo3() }


// MARK: - Unstructured Concurrency
/// In addition to the structured approaches to concurrency described in the previous sections,
/// Swift also supports unstructured concurrency. Unlike tasks that are part of a task group, an unstructured task doesn’t have a parent task.
/// You have complete flexibility to manage unstructured tasks in whatever way your program needs, but you’re also completely responsible for their correctness.

/// To create an unstructured task that runs on the current `actor`, call the ``Task.init(priority:operation:)`` initializer.
/// To create an unstructured task that’s `not` part of the current actor, known more specifically as a `detached task`,
/// call the ``Task.detached(priority:operation:)`` class method.
/// Both of these operations return a task that you can interact with — for example, to wait for its result or to cancel it
func add(_ photo: String, toGalleryNamed: String) async -> Bool {
    print("Let's add some photo\n")
    
    do {
        try await Task.sleep(until: .now + .seconds(.random(in: 1...3)), clock: .continuous)
    } catch {
        print("Something went wrong ;)")
        return false
    }
    
    print("Added photo: \(photo) into gallerry: \(toGalleryNamed)\n")
    return true
}

func foo4() async {
    print("Add new photo\n")
    
    let newPhoto = "Hola"
    let handle = Task {
        return await add(newPhoto, toGalleryNamed: "Spring Adventures")
    }
    let result = await handle.value
    
    print(result, "\n")
}

//Task { await foo4() }
