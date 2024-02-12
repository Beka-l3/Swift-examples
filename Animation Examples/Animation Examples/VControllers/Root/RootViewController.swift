//
//  ViewController.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 28.12.2023.
//

import UIKit
import OSLog


final class RootViewController: UIViewController {
    
    weak var appCoordinator: AppCoordinator?
    
    let animationVCs: [AnimatoinViewController]
    
    let viewComponents: RootVCViewComponents
    
    var shouldUseSplashScreen: Bool
    
    
//    MARK: lifecycle
    init(animationVCs: [AnimatoinViewController] = []) {
        self.animationVCs = animationVCs
        self.viewComponents = .init()
        self.shouldUseSplashScreen = true
        super.init(nibName: nil, bundle: nil)
        Logger.viewCycle.info("Hello from RootVC init")
    }
    
    required init?(coder: NSCoder) {
        self.animationVCs = []
        self.viewComponents = .init()
        self.shouldUseSplashScreen = true
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shouldUseSplashScreen = true
        setupView()
        setupVCs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        appCoordinator?.isLargeNavTitle = false
        setupNavbar()
        
        if let appCoordinator = appCoordinator {
            setStyle(appCoordinator.navigationController.traitCollection.userInterfaceStyle, animated: false)
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
        
        if let appCoordinator = appCoordinator {
            setStyle(appCoordinator.navigationController.traitCollection.userInterfaceStyle, animated: true)
            viewComponents.navigationTableView.reloadData()
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
        navigationItem.hidesBackButton = true
        navigationItem.largeTitleDisplayMode = .always
        
        if !shouldUseSplashScreen && viewComponents.splashView.alpha != 0{
            
            appCoordinator?.appearNavbar(animated: false)
            viewComponents.splashView.disappear()
            
        }
    }
    
    private func setupVCs() {
        for vc in animationVCs {
            vc.appCoordinator = appCoordinator
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
        viewComponents.navigationTableView.scrollToRow(at: .init(row: 0, section: 0), at: .middle, animated: true)
//        viewComponents.navigationTableView.setContentOffset(CGPoint(x: 0, y: -140), animated: true)
    }
    
}


extension RootViewController: UIStyler {
    
    func setStyle(_ style: UIUserInterfaceStyle, animated: Bool) {
        viewComponents.setStyle(style, parent: view, animated: animated)
    }
    
}
