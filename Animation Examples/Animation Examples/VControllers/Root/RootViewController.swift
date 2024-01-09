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
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions")),
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of")),
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable")),
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of")),
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView")),
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and")),
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer")),
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions")),
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of")),
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable")),
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable properties")),
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable properties of")),
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable properties of UIView")),
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable properties of UIView and")),
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable properties of UIView and CALayer")),
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable properties of UIView and CALayer. Animations")),
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable properties of UIView and CALayer. Animations of")),
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable properties of UIView and CALayer. Animations of animatable")),
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable properties of UIView and CALayer. Animations of animatable properties")),
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable properties of UIView and CALayer. Animations of animatable properties if UIView")),
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable properties of UIView and CALayer. Animations of animatable properties if UIView and")),
        BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable properties of UIView and CALayer. Animations of animatable properties if UIView and CAlayer")),
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
        
        shouldUseSplashScreen = true
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
            
        } else {
            
//            scrollToTop()
            
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if let appCoordinator = appCoordinator {
            viewComponents.updateStyle(to: appCoordinator.navigationController.traitCollection.userInterfaceStyle, parent: view)
            viewComponents.navigationTableView.reloadSections([.zero], with: .automatic)
        }
    }
    
    
//    MARK: private func
    private func setupView() {
        if let appCoordinator = appCoordinator {
            viewComponents.setupViews(style: appCoordinator.navigationController.traitCollection.userInterfaceStyle, parent: view)
            viewComponents.navigationTableView.delegate = self
            viewComponents.navigationTableView.dataSource = self
            viewComponents.splashView.delegate = self
        }
    }
    
    private func setupNavbar() {
        navigationItem.title = "Animations"
        navigationItem.hidesBackButton = true
        navigationItem.largeTitleDisplayMode = .always
        appCoordinator?.isLargeNavTitle = true
        
        if !shouldUseSplashScreen && viewComponents.splashView.alpha != 0{
            
            appCoordinator?.appearNavbar(animated: false)
            viewComponents.splashView.disappear()
            
        }
    }
    
}


extension RootViewController: SplashAnimationViewDelegate {
    
    func finishedAnimation() {
        
        appCoordinator?.appearNavbar()
        shouldUseSplashScreen = false
        
        scrollToTop()
        
    }
    
    func scrollToTop() {
//        viewComponents.navigationTableView.scrollToRow(at: .init(row: 0, section: 0), at: .middle, animated: true)
        viewComponents.navigationTableView.setContentOffset(CGPoint(x: 0, y: -140), animated: true)
    }
    
}
