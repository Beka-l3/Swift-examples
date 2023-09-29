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
        
//        for v in view.subviews { print(v.frame) }
//        print()
        
        let subView6 = UIView(frame: .init(x: 45, y: 25, width: 40, height: 40))
        subView6.backgroundColor = .systemPink
//        view.addSubview(subView6)
//        view.insertSubview(subView6, at: 2)
//        view.insertSubview(subView6, aboveSubview: subView2)
//        view.insertSubview(subView6, belowSubview: subView3)
//        view.exchangeSubview(at: 0, withSubviewAt: 4)
        
//        for v in view.subviews { print(v.frame) }
    }
    
}

PlaygroundPage.current.liveView = MyViewController()
