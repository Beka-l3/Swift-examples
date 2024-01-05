//
//  ViewController.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 28.12.2023.
//

import UIKit


final class RootViewController: UIViewController {
    
    weak var appCoordinator: AppCoordinator?
    
    let animationVCs: [AnimationVC] = [
        .init(vc: FirstVC(), details: .init(title: "First", description: "The first view controller")),
        .init(vc: FirstVC(), details: .init(title: "Second", description: "View controller that is the second")),
        .init(vc: FirstVC(), details: .init(title: "Third", description: "Between them is located the third one")),
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
        setupNavbar()
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
    
    private func setupNavbar() {
        navigationItem.title = "Animations"
        appCoordinator?.isLargeNavTitle = true
        
        if !shouldUseSplashScreen {
            
            appCoordinator?.appearNavbar(animated: false)
            viewComponents.splashView.disappear()
            
        }
    }
    
}


extension RootViewController: SplashAnimationViewDelegate {
    
    func finishedAnimation() {
        
        appCoordinator?.appearNavbar()
        shouldUseSplashScreen = false
        
    }
    
}
