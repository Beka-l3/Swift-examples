import UIKit
import PlaygroundSupport

final class MyViewController: UIViewController {
    
    
//    override func loadView() {
//        let view = UIView()
//        view.backgroundColor = .systemPurple
//        self.view = view
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        foo1()
    }
    
    
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
}

let mvc = MyViewController()
mvc.preferredContentSize = CGSize(width: 200, height: 200)
PlaygroundPage.current.liveView = mvc

