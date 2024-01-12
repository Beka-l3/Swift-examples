
/// On iOS, every UIView is backed by a Core Animation CALayer, so you are dealing with CALayers when using a UIView, even though you may not realize it.
/// Unlike NSViews on the Mac, which evolved before Core Animation existed,
/// UIViews are intended to be lightweight wrappers around these CALayers.

/// working directly with CALayers doesn't give you significant performance advantages over UIViews

/// One of the reasons you might want to build a user interface element with CALayers instead of UIViews is that it can be very easily ported to the Mac.
/// UIViews are very different from NSViews, but CALayers are almost identical on the two platforms.
/// This is why the Core Plot framework lays out its graphs using CALayers instead of other UI elements.

/// One thing UIViews provide over CALayers is built-in support for ``user interaction``.
/// They handle hit-testing on touches and other related actions that you would need to build yourself if managing a hierarchy of CALayers.
/// It's not that hard to implement this yourself, but it is extra code you'd need to write when building a CALayer-only interface

/// You will often need to access the underlying layers for a UIView when performing more complex animations than the base UIView class allows.
/// UIView's animation capabilities have grown as the iOS SDK has matured, but there are still a few things that are best done by interacting with the underlying CALayer

/// Simply speaking,`UIView` inherit from ``UIResponder``, handles events from users, contains `CALayer`, which inherit from ``NSObject``, mainly focus on rendering, animation etc


/// `UIView`: Views have more `complex` hierarchy layouts.
/// They can receive user interactions like taps, pinches, cliks and more. Working with UIViews happens on the main thread, it means it is using ``CPU`` power.

/// `CALayer`: Layers on other hand have `simpler` hierarchy.
/// That means they are faster to resolve and quicker to draw on the screen.
/// There is no responder chain overhead unlike with views. Layers are drawn directly on the ``GPU``.
/// It happens on a `separate thread `without burdening the `CPU`.
