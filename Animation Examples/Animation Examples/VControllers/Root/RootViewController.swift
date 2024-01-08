//
//  ViewController.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 28.12.2023.
//

import UIKit


final class RootViewController: UIViewController {
    
    weak var appCoordinator: AppCoordinator?
    
    let animationVCs: [AnimatoinViewController] = [
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer")),
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer")),
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer")),
    ]
    
    let viewComponents: RootVCViewComponents
    
    var shouldUseSplashScreen: Bool
    
    
//    MARK: lifecycle
    init() {
        self.viewComponents = .init()
        self.shouldUseSplashScreen = true
        super.init(nibName: nil, bundle: nil)
        
        self.overrideUserInterfaceStyle = .light
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
            print("light")
            statusBarStyle = .darkContent
            appCoordinator?.updateNavbarStyle(to: .light)
        
        case .dark:
            print("dark")
            statusBarStyle = .lightContent
            appCoordinator?.updateNavbarStyle(to: .dark)
            
        case .unspecified:
            break
        
        @unknown default:
            break
            
        }
        
    }
    
    var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            UIView.animate(withDuration: 0.6) { [unowned self] in
                self.setNeedsStatusBarAppearanceUpdate()
            }
            
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        statusBarStyle
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
        navigationItem.hidesBackButton = true
//        navigationItem.largeTitleDisplayMode = .always
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
