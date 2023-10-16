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
}

let mvc = MyViewController()
mvc.preferredContentSize = CGSize(width: 200, height: 200)
PlaygroundPage.current.liveView = mvc

