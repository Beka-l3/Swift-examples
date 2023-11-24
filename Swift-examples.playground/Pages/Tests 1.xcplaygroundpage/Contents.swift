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




// MARK: - Given-When-Then Testing
/// Given-When-Then (GWT) is a structured way to write unit tests.
/// I find it is particularly useful when I need to write complex unit tests.
/// The structure helps me to write and understand unit test faster than the traditional approach.
/// Using this concept, we break down and write a unit test into three sections.

/// `Given`:  section is the pre-conditions of the tests. Preconditions can be arguments to the function call, value assertion or any test doubles.
///
/// `When`:  describes the actual behaviour of the test. In this section, an operation to be tested is performed.
///
/// `Then`:  section depicts the expected outcome due to the specified behaviour. In this section, we have used assertions statements.
/// We can check an assertion by validating some values, nil or non-nil, true or false, two objects match or not etc.

/// Let’s think about a real world test case scenario.

/// Test case: Add food to a food cart. As a user, I want to add a food item to my food cart and the total food items are increased.

/// Given: The food cart is initially empty. Total food item = 0
/// When: Add three food items in the cart
/// Then: User should have three food items in cart.

/// The Given-When-Then was proposed by Dan North as part of behaviour-driven development.

import XCTest


struct Sut {
    func fullName(_ first: String, _ last: String) -> String {
        first + " " + last
    }
}

func testUppercasedName() {
    let sut = Sut()
    
    // Given
    let firstName = "Jacob"
    let lastName = "Adam"
    
    // When
    let fullName = sut.fullName(firstName, lastName).uppercased()
    
    // Then
    XCTAssertEqual(fullName, "JACOB ADAM")
    
}



// MARK: Benefits
/// `Given-When-Then (GWT) testing in Swift` (and in general) is a beneficial approach to testing
/// because it provides a structured and organized way to write tests that are easy to understand and maintain.
/// Here are some specific benefits of using GWT testing in Swift:

/// - `Clarity`: GWT testing forces the developer to write test cases in a clear, concise and structured manner,
///   which makes it easier for other developers to understand what the test is trying to achieve.
///
/// - `Improved collaboration`: Because GWT testing is structured, it makes it easier for developers to collaborate and work together on testing efforts.
///   Each test case can be broken down into individual steps, and each developer can take on a specific step to complete.
///
/// - `Better test coverage`: GWT testing ensures that all the possible scenarios are tested, which helps improve the overall test coverage of the application.
///
/// - `Faster debugging`: GWT testing makes it easier to identify the root cause of the problem if a test case fails,
///   because each step in the test is clearly defined and can be easily traced back to the problematic code.
///
/// - `Easier maintenance`: GWT testing makes it easier to maintain the test suite over time,
///   because it is easier to understand and update the tests when the underlying code changes.


// MARK: Adopting
/// Adopting Given-When-Then (GWT) testing in a complex Swift project can be challenging, but it is possible with some planning and effort.
/// Here are some steps you can follow to adopt GWT in your complex Swift project:

/// - `Define the scope`: Start by defining the scope of the GWT testing effort.
///   Identify the key components and features of the application that will be covered by GWT testing.
///
/// - `Identify the scenarios`: Once you have defined the scope, identify the scenarios that you want to test.
///   Break each scenario down into individual steps using the GWT format (Given-When-Then).
///
/// - `Write the tests`: Write the tests for each scenario.
///   Use the XCTest framework provided by Swift to write the tests.
///   Make sure that each step in the GWT format is clearly defined and that the tests are easy to read and understand.



/// In conclusion, Given-When-Then (GWT) testing in Swift is a testing approach that structures test cases into three distinct parts:
/// - the given (the preconditions or initial state),
/// - the when (the action being tested),
/// - and the then (the expected outcome).
///
/// This approach helps developers to write tests that are easy to understand, maintain and update.
/// GWT testing ensures that all the possible scenarios are tested, and helps to improve test coverage,
/// debugging, and collaboration between developers.
///
/// Adopting GWT testing in a complex Swift project requires planning, effort, and collaboration,
/// but the benefits make it a worthwhile investment for any development team.
