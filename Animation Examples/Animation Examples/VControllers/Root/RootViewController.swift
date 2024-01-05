//
//  ViewController.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 28.12.2023.
//

import UIKit






final class RootViewController: UIViewController {
    
    weak var appCoordinator: AppCoordinator?
    
    let animationViewControllers: [AnimationVC] = [
        .init(title: "First", vc: FirstVC()),
        .init(title: "Second", vc: FirstVC()),
        .init(title: "Third", vc: FirstVC()),
    ]
    
    let viewComponents: RootVCViewComponents
    
    var shouldUseSplashScreen: Bool
    
    
//    MARK: lifecycle
    init() {
        self.viewComponents = .init()
        self.shouldUseSplashScreen = true
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewComponents = .init()
        self.shouldUseSplashScreen = true
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
        
        if !shouldUseSplashScreen {
            
            appCoordinator?.appearNavbar(animated: false)
            viewComponents.splashView.disappear()
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if shouldUseSplashScreen {
            
            appCoordinator?.disappearNavbar()
            viewComponents.splashView.startAnimation()
            
        }
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
        viewComponents.splashView.delegate = self
    }
}


extension RootViewController: SplashAnimationViewDelegate {
    
    func finishedAnimation() {
        
        appCoordinator?.appearNavbar()
        
    }
    
}
