import UIKit


/// SE-0300: Continuations for interfacing async tasks with synchronous code defines four different functions to suspend the execution and create a continuation

/// - withCheckedContinuation(_:)
/// - withCheckedThrowingContinuation(_:)
/// - withUnsafeContinuation(_:)
/// - withUnsafeThrowingContinuation(_:)

/// As you can see, the framework provides two variants of APIs of the same functions
/// with ``Continuation`` provides a non-throwing context continuation
/// with``ThrowingContinuation`` also allows throwing exceptions in the continuations
/// The difference between `Checked` and `Unsafe` lies in how the `API verifies proper use of the resume function`


/// To `resume` the execution, you’re supposed to call the `continuation` provided by the function only ``once``,
/// by using one of the following continuation functions:
/// - `resume()` resumes the execution without returning a result, e.g. for an async function returning Void.
/// - `resume(returning:)` resumes the execution returning the specified argument.
/// - `resume(throwing:)` resumes the execution throwing an exception and is used for `ThrowingContinuation` only
/// - `resume(with:)` resumes the execution passing a Result object.


/// ...
/// Swift prints this error because the app is `reusing a continuation already used` for the first image, and the standard explicitly forbids this!
/// Remember, you must use a continuation once, and only `once`.

/// When using the `Checked continuation`, the compiler adds code to enforce this rule.
/// When using the Unsafe APIs and you call the resume more than once, however, the app will crash!
/// If you forget to call it at all, the function never resumes.



/*
func classifyImage(_ image: UIImage) async throws -> ImageClassifierService.Classification {
    return try await withCheckedThrowingContinuation { continuation in
        classifyImage(image) { result in
            switch result {
            case .success(let classification):
                continuation.resume(returning: classification)
            case .failure(let error):
                continuation.resume(throwing: error)
            }
        }
    }
}

func classifyImage(_ image: UIImage) async throws -> ImageClassifierService.Classification {
  return try await withCheckedThrowingContinuation { continuation in
    classifyImage(image) { result in
      continuation.resume(with: result)
    }
  }
}
*/

/// Here you use the additional continuation method `resume(throwing:)` that throws an exception in the calling method, passing the specified error.
/// Because the case of `returning` a `Result` type is common,
/// Swift also provides a dedicated,more compact instruction, `resume(with:)` allowing you to reduce what's detailed above to this instead:
