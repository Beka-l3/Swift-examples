import Foundation


// MARK: Test Definitions

/// `Unit Test`: A test written by a programmer for the purpose of ensuring that the production code does what the programmer expects it to do.
/// (For the moment we will ignore the notion that unit tests also aid the design, etc.)

/// `Acceptance Test`: A test written by the business for the purpose of ensuring that the production code does what the business expects it to do.
/// The authors of these tests are business people, or technical people who represent the business. i.e. Business Analysts, and QA.

/// `Integration Test`: A test written by architects and/or technical leads for the purpose of ensuring that a sub-assembly of system components operates correctly.
/// These are plumbing tests. They are not business rule tests. Their purpose is to confirm that the sub-assembly has been integrated and configured correctly.

/// `System Test`: An integration test written for the purpose of ensuring that the internals of the whole integrated system operate as planned.
/// These are plumbing tests. They are not business rule tests. Their purpose is to confirm that the system has been integrated and configured correctly.

/// `Micro-test`: A term coined by Mike Hill (@GeePawHill). A unit test written at a very small scope.
/// The purpose is to test a single function, or small grouping of functions.

/// `Functional Tes`t: A unit test written at a larger scope, with appropriate mocks for slow components.




// MARK: - XCTest
/// Create and run unit tests, performance tests, and UI tests for your Xcode project

/// Use the XCTest framework to write unit tests for your Xcode projects that integrate seamlessly with Xcode’s testing workflow.

/// Tests assert that certain conditions are satisfied during code execution,
/// and record test failures (with optional messages) if those conditions aren’t satisfied.
/// Tests can also measure the performance of blocks of code to check for performance regressions,
/// and can interact with an application’s UI to validate user interaction flows.


