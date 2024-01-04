//
//  ViewController.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 28.12.2023.
//

import UIKit


final class RootViewController: UIViewController {
    
    weak var appCoordinator: AppCoordinator?
    
    let animationViewControllers: [UIViewController]
    let viewComponents: RootVCViewComponents
    
    
//    MARK: lifecycle
    init() {
        self.animationViewControllers = [.init(), .init(), .init()]
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
        
        navigationItem.title = "Animations"
        appCoordinator?.isLargeNavTitle = true
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        
        switch traitCollection.userInterfaceStyle {
        
        case .light:
            print("wow", "light style")
        
        case .dark:
            print("hey", "dark style")
            
        case .unspecified:
            print("hmm", "unspecified")
        
        @unknown default:
            print("what", "unkown default")
            
        }
        
    }
    
    
//    MARK: private func
    private func setupView() {
        viewComponents.setupViews(parent: view)
        viewComponents.navigationTableView.delegate = self
        viewComponents.navigationTableView.dataSource = self
    }
}
