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

