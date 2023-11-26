import UIKit


/// In iOS Development setting alignments and correct intervals might take a long time

/// `Constraints` - rules, that helps OS to layout UI components.

/// First step is to turn off `AutoResizingMask`
let view = UIView()
view.translatesAutoresizingMaskIntoConstraints = false

// MARK: Activation
/// 2 ways to activate
/// - One at a time
/// - Multiple at a time

let heightConstraint = view.heightAnchor.constraint(equalToConstant: 60)

// 1
heightConstraint.isActive = true

// 2
NSLayoutConstraint.activate([
    heightConstraint,
    /// ,,,
    /// ...
])



// MARK: Deactivation
heightConstraint.isActive = false

NSLayoutConstraint.deactivate([
    heightConstraint,
    /// ,,,
    /// ...
])


// MARK: Management
/// After setting  them
/// we can change them

heightConstraint.constant = 100

/// And animate them
/// Need to call `layoutIfNeeded()`
UIView.animate(withDuration: 1) {
    heightConstraint.constant = 120
    view.layoutIfNeeded()
}


// MARK: Resolve Conflicts
/// Usually conflicts happen because of priority
view.widthAnchor.constraint(equalToConstant: 150)
view.widthAnchor.constraint(equalToConstant: 200)

/// To detect them we can set `breakpoint` `UIViewAlertForUnsatisfiableConstraints`

/// Once we detected the confliting constraints
/// we can set them priorities
/// <`MAX` value is 1000 | seams like it is depricated>

let widthConstraint1 = view.widthAnchor.constraint(equalToConstant: 150)
let widthConstraint2 = view.widthAnchor.constraint(equalToConstant: 200)

widthConstraint1.priority = .defaultHigh
widthConstraint2.priority = .defaultLow




// MARK: Intrinsic Content Size
/// Intrinsic content size is the size of the content of all UI elements (label, view, button, etc.).
/// This property will determine what size the view must be in order to place content in it.

/// `UIView` - no intrinisic content size
/// `Sliders` - Defines only the width
/// `Labels, Buttons, and text fields` - Define both width and height
/// `Text views and image views` - Intrinsic content size can vary




// MARK: Contraint Resistance
/// After one constraint when content changes, view can cut some of the content
/// To resist such behaviour
/// we can set special constraints

/// `Content Hugging Priority` - resistence to exeeding intrinsic content size (do not get bigger)
/// `Content Compression Resistence Priority` - resistence to shrinking intrinsic content size (do not get smaller)

view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
view.setContentHuggingPriority(.required, for: .horizontal)




// MARK: Safe Area Layout Guide
/// When supporting multiple devices, one binding may not be enough.
/// For example, if you have a status bar, navigation bar, how can we take into account their sizes on different devices?

/// Luckily, UIKit comes with a safeAreaLayoutGuide property to adapt the safe area
/// so we can focus on the view rather than the dimensions of the distances between devices.
/// This allows us to have the same spacing for iPhone8 or iPhone13, for example.

/// Example with safeAreaLayoutGuide
let label = UILabel()
NSLayoutConstraint.activate([
    label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
    label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
    label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
    label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
])




// MARK: setNeedsLayout
/// The least expensive way to trigger a `layoutSubviews` call is calling `setNeedsLayout` on your view.
/// This will indicate to the system that the view’s layout needs to be recalculated.
/// `setNeedsLayout` executes and returns immediately and does not actually update views before returning.
/// Instead, the views will update on the `next update cycle`,
/// when the system calls `layoutSubviews` on those views and triggers subsequent `layoutSubviews` calls on all their subviews.

/// There should be no user impact from the delay because,
/// even though there is an arbitrary time interval between when `setNeedsLayout` returns and when views are redrawn and laid out,
/// it should never be long enough to cause any lag in the application


// MARK: layoutIfNeeded
/// `layoutIfNeeded` is another method on UIView that will trigger a `layoutSubviews` call in the `future`.
/// Instead of queueing `layoutSubviews` to run on the `next update cycle`, however,
/// the system will call `layoutSubviews` immediately if the view needs a layout update.
/// If you call `layoutIfNeeded` `after calling setNeedsLayout `or after one of the automatic refresh triggers described above,
/// `layoutSubviews` will be called on the view.

/// However, if you call `layoutIfNeeded` `and no action` has indicated to the system that the view needs to be refreshed,
/// `layoutSubviews` will `not` be called.
/// If you call `layoutIfNeeded` on a view twice during the same run loop without updating its layout in between,
/// the second call will not trigger a layoutSubviews call.


// MARK: setNeedsUpdateConstraints
/// Calling `setNeedsUpdateConstraints()` will guarantee a constraint update on the `next` update cycle.
/// It triggers `updateConstraints()` by marking that one of the view’s constraints has been updated.
/// This method works similarly to `setNeedsDisplay()` and `setNeedsLayout()`.


// MARK: updateConstraintsIfNeeded
/// This method is the equivalent of `layoutIfNeeded`, but for views that use Auto Layout.
/// It will check the “constraint update” flag (which can be set automatically,
/// by `setNeedsUpdateConstraints`, or by `invalidateInstrinsicContentSize`).
/// If it determines that the constraints need updating,
/// it will trigger `updateConstraints()` immediately and not wait until the end of the run loop


// MARK: invalidateIntrinsicContentSize
/// Some views that use Auto Layout have an intrinsicContentSize property, which is the natural size of the view given its contents.
/// The intrinsicContentSize of a view is typically determined by the constraints on the elements it contains but can also be overriden to provide custom behavior.
/// Calling invalidateIntrinsicContentSize() will set a flag indicating the view’s intrinsicContentSize is stale and needs to be recalculated at the next layout pass.




/// The `layout`, `display`, and `constraints` of views follow very similar patterns in the way they are updated
/// and how to force updates at different points during the run loop.
/// Each component has a method (`layoutSubviews`, `draw`, and `updateConstraints`) that `actually propagates the updates,`
/// which you can override to manually manipulate views but that you should `not call explicitly` under any circumstance.

/// At the end of the loop is the update cycle,
/// which updates constraints, layout, and display if specific “update constraints,” “update layout,” or “needs display” flags are set.
/// Once these updates are complete, the run loop restarts.

