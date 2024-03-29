//
//  SecondVC.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 13.01.2024.
//

import UIKit


final class WaveAnimationVC: UIViewController, AnimatoinViewController {
    
    let details: AnimatoinViewControllerDetails
    
    weak var appCoordinator: AppCoordinator?
    
    private let viewComponents: WaveAnimationVCViewComponents = .init()
    
    
//    MARK: lifecycle
    init(details: AnimatoinViewControllerDetails) {
        self.details = details
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.details = .init(title: "Wave Animation", description: "")
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        appCoordinator?.isLargeNavTitle = false
        checkState()
        
        if let appCoordinator = appCoordinator {
            setStyle(appCoordinator.navigationController.traitCollection.userInterfaceStyle, animated: false)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if let appCoordinator = appCoordinator {
            setStyle(appCoordinator.navigationController.traitCollection.userInterfaceStyle, animated: true)
        }
    }
    
    
//    MARK: private func
    private func setupViews() {
        viewComponents.setupViews(parent: view)
        viewComponents.button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
    }
    
    private func checkState() {
        
    }
    
    private func setupNavigationItem() {
        navigationItem.title = details.title
    }
    
}


extension WaveAnimationVC: UIStyler {
    
    func setStyle(_ style: UIUserInterfaceStyle, animated: Bool) {
        viewComponents.setStyle(style, parent: view, animated: animated)
    }
    
}


extension WaveAnimationVC {
    
    @objc func handleButton() {
        
        viewComponents.gridOfPolkDots.waveAnimation()
        
    }
    
}
