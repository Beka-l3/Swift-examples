import Foundation


/// Closures are self-contained blocks of functionality that can be passed around and used in your code.
/// Closures in Swift are similar to blocks in C and Objective-C and to lambdas in other programming languages.

/// Closures can capture and store references to any constants and variables from the context in which they’re defined.
/// This is known as closing over those constants and variables. Swift handles all of the memory management of capturing for you.


// MARK: - Capture List
/// A closure can capture constants and variables from the surrounding context in which it’s defined.
/// The closure can then refer to and modify the values of those constants and variables from within its body,
/// even if the original scope that defined the constants and variables no longer exists
