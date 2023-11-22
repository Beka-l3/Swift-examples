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
