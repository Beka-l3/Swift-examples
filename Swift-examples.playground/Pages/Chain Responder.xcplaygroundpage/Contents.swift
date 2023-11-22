import UIKit


/// In iOS, the Responder Chain is the name given to an UIKit-generated linked list of UIResponder objects,
/// and is the foundation for everything regarding events (like touch and motion) in iOS

/// The Responder Chain is something that you constantly deal with in the world of iOS development,
/// and although you rarely have to directly deal with it outside of UITextField keyboard shenanigans,
/// knowledge of how it works allows you to solve event-related problems in very easy/creative ways -
/// you can even build architectures that rely on Responder Chains.

/// In short, UIResponder instances represents objects that can handle and respond to arbitrary events.
/// Many things in iOS are UIResponders, including UIView, UIViewController, UIWindow, UIApplication and UIApplicationDelegate.

/// In turn, an UIEvent represents a single UIKit event that contains a type (touch, motion, remote-control and press)
/// and an optional sub-type (like a specific device motion shake). When a system event like a screen touched is detected,
/// UIKit internally creates `UIEvent` instances and dispatches it to the system event queue by calling `UIApplication.shared.sendEvent().`
/// When the event is retrieved from the queue, UIKit internally determines the first UIResponder capable of handling the event and sends it to the selected one.
/// The selection process differs depending on the event type - while touch events go directly to the touched view itself,
/// other event types will be dispatched to the so called first responder.

/// In order to handle system events, UIResponder subclasses can register themselves as capable of handling specific UIEvent types by overriding the methods specific to that type:
protocol SomeProtocol {
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?)
    func pressesChanged(_ presses: Set<UIPress>, with event: UIPressesEvent?)
    func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?)
    func pressesCancelled(_ presses: Set<UIPress>, with event: UIPressesEvent?)
    func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?)
    func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?)
    func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?)
    func remoteControlReceived(with event: UIEvent?)
}

/// There are ways for you to play with them - besides system events, UIResponders can also respond to arbitrary "actions" in the form of `Selectors`
/// In iOS it can be used for custom actions - which is exactly how UIControls like UIButton can dispatch actions after being touched
/*
    let button = UIButton(type: .system)
    button.addTarget(myView, action: #selector(myMethod), for: .touchUpInside)
*/

/// Although UIResponders can fully detect touch events, handling them isn't an easy task. How do you differ between different types of touches?

/// That's where UIControl excels -
/// these subclasses of UIView abstract the process of handling touch events and expose the ability to assign actions to specific touch events.

/// Internally, touching this button results in the following:

//    let event = UIEvent(...) //An UIKit-generated touch event containing the touch position and properties.
    /// Dispatch a touch event.
    /// Through `hitTest()`, determine which UIView was "selected".
    /// Because an UIControl was selected, directly invoke its target:
//    UIApplication.shared.sendAction(#selector(myMethod), to: myView, from: button, for: event)

/// When a specific target is sent to sendAction,
/// UIKit will directly attempt to call the desired selector at the desired target (crashing the app if it doesn't implement it) - but what if the target is `nil`?

final class MyViewController: UIViewController {
    
    @objc func myCustomMethod() {
        print("SwiftRocks!")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.sendAction(#selector(myCustomMethod), to: nil, from: view, for: nil)
    }
    
}

/// If you run this, you'll see that even though the action was sent from a plain UIView with no target, MyViewController's myCustomMethod will be triggered!

/// When no target is specified, UIKit will search for an UIResponder capable of handling this action just like in the plain UIEvent example.
/// In this case, being able to handle an action relates to the following UIResponder method:
// open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool

/// By default, this method simply checks if the responder implements the actual method. "Implementing" the method can be done in three ways,
/// depending on how much info you want (this applies to any native action/target component in iOS!):
protocol SomeProtocol2 {
    func myCustomMethod()
    func myCustomMethod(sender: Any?)
    func myCustomMethod(sender: Any?, event: UIEvent?)
}

/// Now, what if the responder doesn't implement the method? In this case, UIKit uses the following UIResponder method to determine how to proceed:
// open func target(forAction action: Selector, withSender sender: Any?) -> Any?

/// By default, this will return another UIResponder that may or may not be able to handle the desired action.
/// This repeats until the action is handled or the app runs out of choices.
/// But how does the responders know who to route actions to?

// MARK: Chain Responder
/// As mentioned in the beginning, UIKit handles this by dynamically managing a linked list of UIResponders.
/// The so called first responder is simply the root element of the list, and if a responder can't handle a specific action/event,
/// the action is recursively sent to the next responder of the list until someone can handle the action or the list ends

/// Although inspecting the actual first responder is protected by a private firstResponder property in UIWindow,
/// you can check the Responder Chain for any given responder by checking the next property:
extension UIResponder {
    func responderChain() -> String {
        guard let next = next else {
            return String(describing: self)
        }
        return String(describing: self) + " -> " + next.responderChain()
    }
}

// myViewController.view.responderChain()
/// MyView -> MyViewController -> UIWindow -> UIApplication -> AppDelegate


/// In the previous example where the action was handled by the UIViewController, UIKit first sent the action to the UIView first responder -
/// but since it doesn't implement myCustomMethod the view forwarded the action to the next responder -
/// the UIViewController which happened to have that method in its implementation.

/// While in most cases the Responder Chain is simply be the order of the subviews,
/// you can customize it to change the general flow order.
/// Besides being able to override the next property to return something else,
/// you can force an UIResponder to become the first responder by calling `becomeFirstResponder()`
/// and have it go back to its position by calling `resignFirstResponder()`.

/// This is commonly used in conjunction with UITextField to display a keyboard -
/// UIResponders can define an optional inputView property that only shows up when the responder is the first responder,
/// which is the keyboard in this case
