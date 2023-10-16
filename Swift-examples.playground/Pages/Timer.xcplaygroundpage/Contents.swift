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
}

let mvc = MyViewController()
mvc.preferredContentSize = CGSize(width: 200, height: 200)
PlaygroundPage.current.liveView = mvc

