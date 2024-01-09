//
//  FristVC.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 30.12.2023.
//

import UIKit


final class BasicAnimationsVC: UIViewController, AnimatoinViewController {
    
    /// AnimatoinViewController
    let details: AnimatoinViewControllerDetails
    
    weak var appCoordinator: AppCoordinator?
    
    let animationVMs: [AnimationVM]
    
    private let viewComponents: BasicAnimationsViewComponents = .init()
    
    
//    MARK: lifecycle
    init(details: AnimatoinViewControllerDetails, animationVMs: [AnimationVM] = []) {
        self.details = details
        self.animationVMs = animationVMs
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.details = .init(title: "", description: "")
        self.animationVMs = []
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = details.title
        appCoordinator?.isLargeNavTitle = false
    }
    
    
//    MARK: private func
    private func setupViews() {
        if let appCoordinator = appCoordinator {
            viewComponents.setupViews(style: appCoordinator.navigationController.traitCollection.userInterfaceStyle, parent: view)
            viewComponents.animationTableView.delegate = self
            viewComponents.animationTableView.dataSource = self
        }
    }
    
}

