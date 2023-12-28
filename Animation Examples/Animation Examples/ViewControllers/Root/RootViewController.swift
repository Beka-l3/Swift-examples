//
//  ViewController.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 28.12.2023.
//

import UIKit


final class RootViewController: UIViewController {
    
    let animationViewControllers: [UIViewController]
    let viewComponents: RootVCViewComponents
    
    
//    MARK: lifecycle
    init() {
        self.animationViewControllers = []
        self.viewComponents = .init()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.animationViewControllers = []
        self.viewComponents = .init()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }

    
//    MARK: private func
    private func setupView() {
        viewComponents.setupViews(parent: view)
    }
}

