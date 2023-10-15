import UIKit
import PlaygroundSupport

final class MyViewController: UIViewController {
    
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .systemPurple
        self.view = view
    }
    
    
}

PlaygroundPage.current.liveView = MyViewController()


