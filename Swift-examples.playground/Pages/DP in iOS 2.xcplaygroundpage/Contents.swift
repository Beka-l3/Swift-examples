import Foundation

/// `Models` — responsible for the domain data or a data access layer which manipulates the data, think of ‘Person’ or ‘PersonDataProvider’ classes.

/// `Views` — responsible for the presentation layer (GUI), for iOS environment think of everything starting with ‘UI’ prefix.

/// `Controller/Presenter/ViewModel `— the glue or the mediator between the Model and the View,
/// in general responsible for altering the Model by reacting to the user’s actions performed on the View and updating the View with changes from the Model.




// MARK: - MVC
/// The ViewController contains the View and owns the Model. The problem is that we used to write the controller code as well as the view code in the ViewController.
/// It makes the ViewController too complex. That’s why we called it a Massive View Controller. While writing a test for the ViewController, you need to mock the view and the life cycle of it.
/// But views are difficult to be mocked. And we actually don’t want to mock the view if we only want to test the controller logic. All these things make writing tests so complicated




// MARK: - MVP
/// Model View Presenter has three components: the Presenter (UIKit independent mediator), the Passive View (UIView and/or UIViewController) and the Model.
/// This pattern defines Views as recipients of the UI events, which then call the appropriate Presenter as needed.
/// The Presenter is, in fact, responsible for updating the View with the new data returned by the Model. View is more loosely coupled to the model.
/// The Presenter is responsible for binding the Model to the View. Easier to unit test because interaction with the view is through an interface.
/// Usually View to Presenter = map one-to-one. Complex views may have multi presenters.




// MARK: - MVVM
/// In MVVM, the View consists of only visual elements like layout, animation, initializing UI components, etc.
/// There’s a special layer between the View and the Model called the ViewModel. The ViewModel is a canonical representation of the View.
/// That is, the ViewModel provides a set of interfaces, each of which represents a UI component in the View.
/// We use a technique called “binding” to connection UI components to ViewModel interfaces.

/// Specifically, for MVVM in iOS development, the UIView/UIViewController represent the View. We only do:
/// 1) Initiate/Layout/Present UI components.
/// 2) Bind UI components with the ViewModel.

/// On the other hand, in the ViewModel, we do:
/// 1) Write controller logics such as pagination, error handling, etc.
/// 2) Write presentational logic, provide interfaces to the View.


/// In Swift, there are various ways to achieve the “binding”:
/// - KVO (Key-Value Observing) pattern,
/// - 3rd party libraries for FRP (Functional Reactive Programming) such as RxSwift and ReactiveCocoa and by crafting it yourself.

/// `Distribution` — it is not clear in our tiny example, but, in fact, the MVVM’s View has more responsibilities than the MVP’s View.
/// Because the first one updates it’s state from the View Model by setting up bindings, when the second one just forwards all events to the Presenter and doesn’t update itself.

/// `Testability` — the View Model knows nothing about the View, this allows us to test it easily.
/// The View might be also tested, but since it is UIKit dependant you might want to skip it.

/// `Easy of use` — its has the same amount of code as the MVP in our example,
/// but in the real app where you’d have to forward all events from the Viewto the Presenter and to update the View manually,
/// MVVM would be much skinnier if you used bindings.

/// The MVVM is very attractive, since it combines benefits of the aforementioned approaches, and, in addition,
/// it doesn’t require extra code for the View updates due to the bindings on the View side. Nevertheless, testability is still on a good level




// MARK: - VIPER
// Problems with MVVM
/// - It is complicated on iOS by a lack of bindings and by a tendency to continue putting too many responsibilities that were in a bloated view controller class into a bloated view model class instead

/// - Without being broken down into good, reusable, testable, and single-responsibility components, any MVVM implementation is of limited usefulness

/// - Simply saying that “we’re using MVVM” or simply having a rough implementation of MVVM in a project, without taking a thorough look at how it’s improving your code reuse,
/// efficiency and adherence to the single responsibility principle will mislead you as to how valuable or maintainable the architecture really is.


/// `VIPER` is an application of Clean Architecture to iOS apps.
/// The word VIPER is a backronym for View, Interactor, Presenter, Entity, and Routing.
/// Clean Architecture divides an app’s logical structure into distinct layers of responsibility.
/// This makes it easier to isolate dependencies (e.g. your database) and to test the interactions at the boundaries between layers.

/// Main parts:
/// `View`: displays what it is told to by the Presenter and relays user input back to the Presenter.
/// `Interactor`: contains the business logic as specified by a use case.
/// `Presenter`: contains view logic for preparing content for display (as received from the Interactor) and for reacting to user inputs (by requesting new data from the Interactor).
/// `Entity`: contains basic model objects used by the Interactor.
/// `Routing`: contains navigation logic for describing which screens are shown in which order.

