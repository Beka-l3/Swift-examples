import UIKit
import PlaygroundSupport

final class MyViewController: UIViewController {
    
    override func loadView() {
        let view = UIView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let subView1 = UIView(frame: .init(x: 10, y: 10, width: 40, height: 40))
        let subView2 = UIView(frame: .init(x: 20, y: 20, width: 40, height: 40))
        let subView3 = UIView(frame: .init(x: 30, y: 30, width: 40, height: 40))
        let subView4 = UIView(frame: .init(x: 40, y: 40, width: 40, height: 40))
        let subView5 = UIView(frame: .init(x: 50, y: 50, width: 40, height: 40))
        
        subView1.backgroundColor = .systemRed
        subView2.backgroundColor = .systemBlue
        subView3.backgroundColor = .systemGreen
        subView4.backgroundColor = .black
        subView5.backgroundColor = .systemPurple
        
        view.addSubview(subView1)
        view.addSubview(subView2)
        view.addSubview(subView3)
        view.addSubview(subView4)
        view.addSubview(subView5)
        
        
        for v in view.subviews { print(v.frame) }
        print()
        
        
        let subView6 = UIView(frame: .init(x: 45, y: 25, width: 40, height: 40))
        subView6.backgroundColor = .systemPink
//        subView6.layer.zPosition = -1
//        view.addSubview(subView6)
//        view.insertSubview(subView6, at: 2)
//        view.insertSubview(subView6, aboveSubview: subView2)
//        view.insertSubview(subView6, belowSubview: subView3)
//        view.exchangeSubview(at: 0, withSubviewAt: 4)
        
        for v in view.subviews { print(v.frame) }
        print()
    }
    
}


final class MyViewController1: UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .black
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.isHidden = true
        print("Hello form Will")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("Hello form Did")
    }
}

PlaygroundPage.current.liveView = MyViewController()
