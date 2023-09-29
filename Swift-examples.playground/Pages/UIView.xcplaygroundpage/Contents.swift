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
///




















