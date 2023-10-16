import UIKit
import PlaygroundSupport

final class MyViewController: UIViewController {
    
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemPurple
        self.view = view
    }
    
    
    
    func foo1() {
        
    }
    
    
}

PlaygroundPage.current.liveView = MyViewController()

