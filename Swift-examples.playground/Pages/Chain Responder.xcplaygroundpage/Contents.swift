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

    func viewDidLoad() {
        UIApplication.shared.sendAction(#selector(myCustomMethod), to: nil, from: view, for: nil)
    }
}

