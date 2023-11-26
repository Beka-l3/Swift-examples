import UIKit

/*
    @MainActor
    class UIView : UIResponder
*/

/// ``UIView`` is the fundamental UI building block
/// This class defines a behaviors that are common to all views
/// A view object renders content within its `bounds` rectangle, and handles any interactions with that `content`

/// View objects are the main way your application interacts with the user.
/// They have a number of responsibilities.
///
/// Here are just a few:
/// - **Drawing and animation**
///   - Views draw content in their rectangular area using `UIKit` or `Core Graphics`.
///   - You can animate some view properties to new values.
///
/// - **Layout and subview management**
///   - Views may contain `zero` or more subviews.
///   - Views can adjust the size and position of their subviews.
///   - Use `Auto Layout` to define the rules for resizing and repositioning your views in response to changes in the view hierarchy.
///
/// - **Event handling**
///   - A view is a subclass of ``UIResponder`` and can respond to touches and other types of events.
///   - Views can install gesture recognizers to handle common gestures.

/// By default, when a subview’s visible area extends outside of the bounds of its superview,
/// no clipping of the subview’s content occurs. Use the `clipsToBounds` property to change that behavior.

/// The `frame` and `bounds` properties define the geometry of each view.
/// The `frame` property defines the origin and dimensions of the view in the coordinate system of its superview.
/// The `bounds` property defines the internal dimensions of the view as it sees them, and its use is almost exclusive to custom drawing code.
/// The `center` property provides a convenient way to reposition a view without changing its frame or bounds properties directly.


// MARK: - Create a view
/// When creating a view, you typically specify its initial size and position relative to its future superview.

let rect = CGRect(x: 10, y: 10, width: 100, height: 100)
let myView = UIView(frame: rect)

/// To add a subview to another view, call the `addSubview(_:)` method on the superview.
/// You may add any number of subviews to a view, and sibling views may overlap each other without any issues in iOS.
/// Each call to the`addSubview(_:)` method places the new view on top of all other siblings.
/// You can specify the relative `z-order` of subview by adding it using the `insertSubview(_:aboveSubview:)` and `insertSubview(_:belowSubview:)` methods.
/// You can also exchange the position of already added subviews using the `exchangeSubview(at:withSubviewAt:)` method.

/// After creating a view, create Auto Layout rules to govern how the size and position of the view change in response to changes in the rest of the view hierarchy.


// MARK: - Draw Views
/// View drawing occurs on an as-needed basis.
/// For views that contain custom content using UIKit or Core Graphics, the system calls the view’s `draw(_:)` method.
/// When the actual content of your view changes, it’s your responsibility to notify the system that your view needs to be redrawn.
/// You do this by calling your view’s `setNeedsDisplay()` or `setNeedsDisplay(_:)` method of the view.
/// These methods let the system know that it should update the view during the next `drawing cycle`.
/// Because it waits until the next drawing cycle to update the view, you can call these methods on multiple views to update them at the same time.

/// You should only be calling `setNeedsDisplay` if you override `drawRect` in a subclass of `UIView` which is basically a custom view drawing something on the screen,
/// like lines, images, or shapes like a rectangle.
/// When you add an `imageView` or a `UIButton` as a subview or make changes to any subview, you need not call this method
/// For labels and other standard controls, changing the text will automatically cause the label to redraw so you don't need to do this yourself.

// MARK: - Animate View
/// Changes to several view properties can be animated — that is, changing the property creates an animation starting at the current value and ending at the new value that you specify.
/// The following properties of the ``UIView`` class are animatable:
/// - `frame`
/// - `bounds`
/// - `center`
/// - `transform`
/// - `alpha`
/// - `backgroundColor`
/// To animate your changes, create a `UIViewPropertyAnimator` object and use its handler block to change the values of your view’s properties.
/// The `UIViewPropertyAnimator` class lets you specify the duration and timing of your animations, but it performs the actual animations.
/// You can pause a property-based animator that’s currently running to interrupt the animation and drive it interactively.


// MARK: - Threading Consideration
/// Manipulations to your app’s user interface must occur on the `main thread`.
/// Thus, you should always call the methods of the ``UIView`` class from code running in the main thread of your app.
/// The only time this may not be strictly necessary is when creating the view object itself, but all other manipulations should occur on the main thread.


// MARK: - SubClassing notes
/// The `UIView` class is a key subclassing point for visual content that also requires user interactions.
/// Although there are many good reasons to subclass ``UIView``,
/// it is recommended that you do so only when the basic ``UIView`` class or the standard system views do not provide the capabilities that you need.
/// Subclassing requires more work on your part to implement the view and to `tune` its `performance`.


