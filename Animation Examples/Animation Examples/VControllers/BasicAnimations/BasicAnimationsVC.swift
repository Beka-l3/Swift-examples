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
    
    let animationViews: [AnimationView]
    
    private let viewComponents: BasicAnimationsViewComponents = .init()
    
    private(set) var isDescriptionHidden: Bool = false {
        didSet {
            viewComponents.animationTableView.reloadSections([.zero], with: .none)
        }
    }
    
    
//    MARK: lifecycle
    init(details: AnimatoinViewControllerDetails, animationViews: [AnimationView] = []) {
        self.details = details
        self.animationViews = animationViews
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.details = .init(title: "", description: "")
        self.animationViews = []
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
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if let appCoordinator = appCoordinator {
            viewComponents.setStyle(appCoordinator.navigationController.traitCollection.userInterfaceStyle, parent: view, animated: true)
            viewComponents.animationTableView.reloadSections([.zero], with: .none)
        }
    }
    
//    MARK: private func
    private func setupViews() {
        if let appCoordinator = appCoordinator {
            viewComponents.setupViews(style: appCoordinator.navigationController.traitCollection.userInterfaceStyle, parent: view)
            viewComponents.animationTableView.delegate = self
            viewComponents.animationTableView.dataSource = self
            viewComponents.descriptionVisibilityButton.target = self
            viewComponents.descriptionVisibilityButton.action = #selector(handleDescriptionVisibilityButton)
        }
    }
    
    private func checkState() {
        viewComponents.setDescriptionVisibilityButtonState(isDescriptionHidden: isDescriptionHidden)
    }
    
    private func setupNavigationItem() {
        navigationItem.title = details.title
        navigationItem.rightBarButtonItem = viewComponents.descriptionVisibilityButton
    }
}


extension BasicAnimationsVC {
    
    @objc func handleDescriptionVisibilityButton() {
        isDescriptionHidden.toggle()
        viewComponents.setDescriptionVisibilityButtonState(isDescriptionHidden: isDescriptionHidden)
    }
    
}
