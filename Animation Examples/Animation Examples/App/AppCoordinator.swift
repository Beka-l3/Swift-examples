//
//  AppCoordinator.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 28.12.2023.
//

import UIKit


protocol AppCoordinatorForSceneDelegate {
    func setupScene(with window: UIWindow)
}


final class AppCoordinator {
    
    let rootViewController: RootViewController
    let navigationController: UINavigationController
    

//    MARK: lifecycle
    init() {
        self.rootViewController = .init()
        self.navigationController = .init(rootViewController: self.rootViewController)
        
        rootViewController.appCoordinator = self
    }
    
    
    
}


extension AppCoordinator: AppCoordinatorForSceneDelegate {
    
    func setupScene(with window: UIWindow) {        
        window.rootViewController = navigationController
    }
    
}


extension AppCoordinator {
    
    func setNavigationStyle(title: String, isPreferredLargeTitle: Bool) {
        navigationController.navigationItem.title = title
        navigationController.navigationBar.prefersLargeTitles = isPreferredLargeTitle
        
        navigationController.navigationItem.hidesBackButton = true
        navigationController.isNavigationBarHidden = false
        navigationController.navigationBar.tintColor = .systemPurple
        navigationController.navigationItem.largeTitleDisplayMode = .always
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let largeTitleAttr = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 36)
        ]
        let titleAttr = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22)
        ]
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundEffect = blurEffect
        appearance.backgroundColor = UIColor(white: 1, alpha: 0.2)
        appearance.largeTitleTextAttributes = largeTitleAttr
        appearance.titleTextAttributes = titleAttr
        
        let largeAppearance = UINavigationBarAppearance()
        largeAppearance.backgroundEffect = nil
        largeAppearance.backgroundColor = .clear
        largeAppearance.shadowColor = .clear
        largeAppearance.largeTitleTextAttributes = largeTitleAttr
        largeAppearance.titleTextAttributes = titleAttr
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = largeAppearance
    }
    
}
