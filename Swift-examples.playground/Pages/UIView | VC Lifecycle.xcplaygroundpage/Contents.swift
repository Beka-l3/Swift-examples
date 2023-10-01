import UIKit

/// To use the view in proper positions, we must know when the view is `created`, `loaded`, `appeared`, `changed`, `disappeared`, and `terminated`.
/// `Subclasses` of `UIViewController` is responsible for managing the views (aka. UIViews).
/// View controller has one `root view`, which is a `UIView` instance. The important thing here is how they work together

/// `UIViewController` handles all the magic `behind` `UIView` while `UIView` just represents the screen and some content to the user.
/// UIViewController tells the `root UIView` object when to come to the screen. First, the view controller creates its root view and `loads` it.
/// After loading, it tells the view to appear on the screen and disappear when necessary

/// Furthermore, a view controller might be a child of `another` view controller.
/// So, the view controller's lifecycle not only cares about its root view but also includes the relationship with other view controllers,
/// like whether it moved to the parent view controller or not

/// Lastly, the view controller’s root view (aka. UIView) has its own content and lifecycle.
/// The root view has subviews like buttons, labels, switches, or other UIView subclasses.
/// The lifecycle of the subviews is, in most cases, not considered by every developer.
/// But there is one common case which is embedding a view controller into another.
/// In this case, we need to imitate the lifecycle actions for both view controllers’ views and call proper methods when necessary


// MARK: Load View
/// This is where the root view of the view controller is loaded.
/// The `view` property of `UIViewController` is ``nil`` at the moment
/// We call this method if we want to create a `custom view` and set it to the view property.
/// We we call this method and want  to use custom view, then we do not call `super.loadView()`
/// Because, bydefault the method creates root view instead of us


// MARK: view Did Load
/// This is called only once after creating the view and loading it into memory. But the ``bounds`` of the view is not defined yet.
/// We generally override this method to initialize the objects which the view controller will use. We shouldn’t forget to call `super` when we override


// MARK: view Will Appear
/// This method is called right before the view appears on the screen.
/// When this is called, the view’s `bounds are defined`, but the` orientation is not set yet`.
/// We need to be careful while using appear methods since they will be called every time the view comes to the screen.
/// Similarly, we shouldn’t forget to call `super`.


// MARK: view Did Appear
/// This method is called right after the view is visible to the user. It’s a good place to start `animations`.
/// Same as before, we shouldn’t forget to call `super`


// MARK: view Will Layout Subviews
/// This is the first place to learn the `bounds` of the view in the lifecycle.
/// This is also called right `before` ``layoutSubviews`` method is triggered in `UIView`.
/// This is also called when the `subviews` of the `root view` are loaded.
/// For example, this is called when the cells of the collection view are loaded.


// MARK: view Did Layout Subviews
/// This is called right `after` ``layoutSubviews`` called. The subviews have been set, and `size`, `position`, and `constraints` are applied
/// `viewWillLayoutSubviews` and `viewDidLayoutSubviews` are also called when
///  the `orientation` of the screen `changes` between portrait and landscape modes.
///  So the key point is whenever the `bounds` of the view are `updated`, or the view layout is `recalculated`,
///  both methods will be called.
///  Similarly, we shouldn’t forget to call super at some point in these methods


// MARK: view Will Disappear
/// This is called when the view is about to disappear from the screen.
/// One thing we can do here is to `save` the `user data` to not lose anything important.
/// Another thing we might be `canceling` is `network requests.`
/// We can override this method also if we `want to hand over first responder` jobs to another view when the view disappears


// MARK: view Did Disappear
/// This is called when the view is disappeared from the screen. The view is removed from the view hierarchy at the moment


/*
  
                                                                                            ----> (did Deceive Memory Warning)
                                                                                            |           |
                                                                                            |           |
                           yes                                                              |           ˇ
     Does view exist -----------> [view Will Appear] ------> [view Did appear] -------> view is visible on screen
      ^                 |                    ^                                                               |
      |                 | no                 |                                                               |
      |                 |                    |                                                               |
      |                 ˇ                    |                                                               |
      |            [load view] -----> [view did load]                                                        | view removed
      |                                                                                                      | from screen
      |                                                                                                      |
      |   view asked                                                                                         |
      |   to appear                                                                                          |
      |                                                                                                      |
      |                                                                                                      |
      -------------------------------------------- [view Did Disappear] <----------- [view Will Disappear] <--
        view not visible on screen
*/

/// We took a look at the most common relationship, view and view controller relationship which was also a default one implemented by UIKit.
/// But the view controller not only gets in a relationship with a view but also with other view controllers like a child and parent




// MARK: - Relationship
/// Understanding this relationship and the lifecycle of the view controller is important if we `embed` one view controller into another.
/// Because we might need to manually call some lifecycle methods to inform the system about the state


// MARK: Adding a ViewController as a child to Another ViewController
let childViewController = UIViewController()
let parentViewController = UIViewController()
parentViewController.addChild(childViewController)
parentViewController.view.addSubview(childViewController.view)

// Time to setup auto-layout constraints for childViewController.view
// Example:
//   NSLayoutConstraint.activate([
//       childViewController.view.topAnchor.constraint(equalTo: parentViewController.view.topAnchor)
//   ])

childViewController.didMove(toParent: parentViewController)


/// After creating view controllers, we add the child to the parent.
/// This addition automatically calls `childViewController.willMove(toParent: parentViewController)` for us.
/// So, we don’t need to call it manually.

/// Then, we need to add the child view controller’s view to the parent’s view to have a `child-parent` relationship for views.
/// The system will `load both views` and will add one to another with our call `addSubview`.

/// Then we inform the system by calling d`idMove(toParent:).`
/// The system will handle the rest of displaying the view controller and calling the view controller’s necessary methods in its lifecycle like `viewDidLoad`, `viewDidAppear`, etc


// MARK: Removing the Child ViewController from the Parent ViewController
childViewController.willMove(toParent: nil)
childViewController.view.removeFromSuperview()
childViewController.removeFromParent()


/// While removing the child view controller from the parent,
/// we have to call `willMove(toParent:)` method with nil to inform the system that the child view controller will be removed from the parent.
/// Then, we remove its view and later itself from the parent.

///  As we see, we don’t need to call `didMove(toParent:)` method while we’re removing it.
///  `removeFromParent` method automatically calls that method for us.

/// Additionally, we can override both `willMove(toParent:)` and `didMove(toParent:)`.
/// If we need to know in a view controller that it’s been added as a child to another view controller,
/// we can `override` these methods and implement our custom actions


