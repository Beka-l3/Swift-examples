import UIKit
import PlaygroundSupport

final class MyViewController: UIViewController {
    
    lazy var btn1: UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = .init(origin: .zero, size: .init(width: 100, height: 40))
        btn.setTitle("Animate", for: .normal)
        btn.backgroundColor = .black
        btn.setTitleColor(.white, for: .normal)
        
        btn.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return btn
    }()
    
    lazy var someView: UIView = {
        let view = UIView()
        view.frame = .init(origin: .zero, size: .init(width: 100, height: 40))
        view.backgroundColor = .systemGreen
        
        return view
    }()
    
    var center: CGPoint {
        get { view.center }
    }
    
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
        foo3()
    }
    
    
//    MARK: - func
    func foo1() {
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
    
    /// When `myView` is add as an subiew to the `view`
    /// layer of `myView` is added as an sublayer to the `view.layer` <<under the hood>>
    func foo2() {
        print(view.subviews)
        print()
        print(view.layer.sublayers ?? "Nil")
    }
    
    func foo3() {
        btn1.center = .init(x: center.x, y: 400)
        someView.center  = .init(x: center.x, y: 40)
        
        view.addSubview(btn1)
        view.addSubview(someView)
        
        let someLayer = CALayer()
        someLayer.frame = .init(
            origin: .init(x: 15, y: 10),
            size: .init(width: 70, height: 20)
        )
        someLayer.backgroundColor = UIColor.systemRed.cgColor
        
        someView.layer.addSublayer(someLayer)
    }
    
    /// CALayer has UIView as a delegate
    /// when property changed, it calls ``action(for: forKey:)`` to get info about animation
    /// if that code black is not in the `UIView.animate` then it returns `nil`
    /// otherwise it returns pararmeters from `UIView.animate`
    /// if CALayer has no delegate, that it uses default paramaeters from it's action dictionary
    /// Changing `view.layer.frame` affects `view.frame`, and otherway
    @objc func handleButton() {
        UIView.animate(withDuration: 1) { [unowned self] in
            var y: CGFloat = self.someView.center.y > 50 ? 40 : 100
            self.someView.center = .init(x: center.x, y: y)
//            var y: CGFloat = self.someView.layer.frame.origin.y > 30 ? 20 : 40
//            self.someView.layer.frame.origin = .init(x: self.someView.layer.frame.origin.x, y: y)
        }
//        print(someView.frame)
//        print(someView.layer.frame)
        
//        var y: CGFloat = someView.layer.frame.origin.y > 30 ? 20 : 40
//        someView.layer.frame.origin = .init(x: someView.layer.frame.origin.x, y: y)
        
//        someView.layer.sublayers?.forEach({ layer in
//            var y: CGFloat = layer.frame.origin.y > 20 ? 10 : 30
//            layer.frame.origin = .init(x: 15, y: y)
//        })
    }
    
    // MARK: IMPORTANT
    /// UIView can be a `delegate` `only` for ``1`` layer.
    /// Even programmatically it can be delegate for more than 1. Animations will not work and will lead to crash
    
}

let mvc = MyViewController()
mvc.preferredContentSize = CGSize(width: 200, height: 200)
PlaygroundPage.current.liveView = mvc

