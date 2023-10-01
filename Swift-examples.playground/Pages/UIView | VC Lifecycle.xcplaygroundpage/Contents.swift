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





