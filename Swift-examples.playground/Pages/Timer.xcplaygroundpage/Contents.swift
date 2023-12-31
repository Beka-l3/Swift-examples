import UIKit
import PlaygroundSupport

final class MyViewController: UIViewController {
    
    
//    MARK: - lifecycle
    override func loadView() {
        let view = UIView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        foo1()
        foo5()
    }
    
    
//    MARK: - func
    func foo1() {
        let center = view.center
        
        let layer1 = CALayer()
        layer1.backgroundColor = UIColor.black.cgColor

        layer1.frame = .init(
            origin: .init(x: 50, y: 50),
            size:  .init(width: 100, height: 100)
        )

        let myView = UIView()
        myView.frame = .init(
            origin: .zero,
            size:  .init(width: 200, height: 200)
        )
        myView.center = .init(x: center.x, y: center.y - 100)
        myView.backgroundColor = .systemBlue
        myView.layer.addSublayer(layer1)
        
        view.addSubview(myView)
    }
    
    
    func foo2() { // repeating timer that calls a @objc func
        let timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(fireTimer),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc func fireTimer() {
        print("Timer fired!")
    }
    
    
    func foo3() { // reapeating timer that runs a closure
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            print("Timer fired! Closure")
        }
    }
    
    
    func foo4() { // non-repeating timers
        let timer1 = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(fireTimer),
            userInfo: nil,
            repeats: false
        )

        let timer2 = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
            print("Timer fired!")
        }
        
        // Another way to do that
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            print("Timer fired!")
        }
    }
    
    
    func foo5() { // End timer
        var runCount = 0

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            print("Timer fired!")
            runCount += 1

            if runCount == 3 {
                timer.invalidate()
            }
        }
    }
    
    var timer6: Timer?
    var runCount6 = 0
    func foo6() { // same as foo5() but with a @objc func
        timer6 = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(fireTimer6),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc func fireTimer6() {
        print("Timer fired!")
        runCount6 += 1

        if runCount6 == 3 {
            timer6?.invalidate()
        }
    }
    
    /// Alternatively, you can do without the timer property by making fireTimer() accept the timer as its parameter.
    /// This will automatically be passed if you ask for it
    @objc func fireTimer62(timer: Timer) {
        print("Timer fired!")
        runCount6 += 1

        if runCount6 == 3 {
            timer.invalidate()
        }
    }
    
    
    /// can attach some context that stores extra information about what triggered the timer
    /// This is a dictionary, so you can store pretty much any data you like – the event that triggered the timer,
    /// what the user was doing, what table view cell was selected, and so on
    var runCount7 = 0
    func foo7() {
        let context = ["user": "@twostraws"]
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: context, repeats: true)
    }
    
    @objc func fireTimer7(timer: Timer) {
        guard let context = timer.userInfo as? [String: String] else { return }
        let user = context["user", default: "Anonymous"]

        print("Timer fired by \(user)!")
        runCount7 += 1

        if runCount7 == 3 {
            timer.invalidate()
        }
    }
    
    
    func foo8() { // tolerance
        let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        timer.tolerance = 0.2
    }
    
    
    /// One common problem folks hit when using timers is that they won’t fire when the user is `interacting` with your app.
    /// For example, if the user has their finger touching the screen so they can scroll through a table view, your regular timers won’t get fired.
    
    /// This happens because we’re implicitly creating our timer on the `defaultRunLoopMode`, which is effectively the `main thread` of our application.
    /// This will then get `paused` while the user is actively `interacting` with our `UI`, then reactivated when they stop
    
    /// The easiest solution is to create the timer without scheduling it `directly`, then add it by hand to a `runloop` of your choosing.
    /// In this case, ``.common`` is the one we want: it allows our timers to fire even when the UI is being used
    func foo9() {
        let context = ["user": "@twostraws"]
        let timer = Timer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: context, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
    }
    
    
    /// Some people, particularly those making games,
    /// try to use timers to have some work done before every frame is drawn – i.e., 60 or 120 frames per second, depending on your device.
    
    /// This is a mistake: timers are not designed for that level of accuracy,
    /// and you have no way of knowing how much time has elapsed since the last frame was drawn.
    /// So, you might think you have 1/60th or 1/120th of a second to run your code,
    /// but in practice half of that might already have passed before your timer was triggered
    
    /// So, if you want to have some code run immediately after the previous display update, you should use `CADisplayLink` instead
    func foo10() {
        let displayLink = CADisplayLink(target: self, selector: #selector(fireTimer))
        displayLink.add(to: .current, forMode: .default)
    }
}

let mvc = MyViewController()
mvc.preferredContentSize = CGSize(width: 200, height: 200)
PlaygroundPage.current.liveView = mvc

