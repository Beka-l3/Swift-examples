//
//  TFYViewController.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 24.01.2024.
//

import UIKit


final class TFYViewController: UIViewController, AnimatoinViewController {
    
    
    let details: AnimatoinViewControllerDetails
    
    weak var appCoordinator: AppCoordinator?
    
    
//    MARK: private properties
    private let viewComponents: TFYVCViewComponents = .init()
    
    
//    MARK: lifecycle
    init(details: AnimatoinViewControllerDetails) {
        self.details = details
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        self.details = .init(title: "TFY View Controller", description: "")
        super.init(coder: coder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        
        appCoordinator?.isLargeNavTitle = false
        checkState()
        
        if let appCoordinator = appCoordinator {
            setStyle(appCoordinator.navigationController.traitCollection.userInterfaceStyle, animated: false)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
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
        viewComponents.bubbleTopbar.delegate = self
        
        viewComponents.btn.addTarget(self, action: #selector(handleBtn), for: .touchUpInside)
        
    }
    
    private func checkState() {
        
    }
    
    private func setupNavigationItem() {
        navigationItem.title = details.title
    }
    
    
}


extension TFYViewController: UIStyler {
    
    func setStyle(_ style: UIUserInterfaceStyle, animated: Bool) {
//        viewComponents.setStyle(style, parent: view, animated: animated)
    }
    
}


extension TFYViewController {
    
    @objc func handleBtn() {
        viewComponents.thanksTicketView.show()
    }
    
}


extension TFYViewController: BubbleTopbarViewDelegate {
    func tapOnAvatar() {
        navigationController?.popViewController(animated: true)
    }
    
    func tapOnNotifications() {
        viewComponents.bubbleTopbar.setNotificationsCount(.random(in: 0...150))
        viewComponents.bubbleTopbar.setData(leftToShare: .random(in: 0...150), yourBalance: .random(in: 0...150), remainingDays: .random(in: 0...150))
    }
}
