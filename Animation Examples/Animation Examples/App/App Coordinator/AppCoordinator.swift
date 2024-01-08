//
//  AppCoordinator.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 28.12.2023.
//

import UIKit


final class MyNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        topViewController?.preferredStatusBarStyle ?? .default
    }
    
}

final class AppCoordinator {
    
    let rootViewController: RootViewController
    let navigationController: MyNavigationController
    

//    MARK: lifecycle
    init() {
        self.rootViewController = .init()
        self.navigationController = .init(rootViewController: self.rootViewController)
        
        rootViewController.appCoordinator = self
        
        setupNavbar()
    }
    
    
    
}


/// AppCoordinator For SceneDelegate
protocol AppCoordinatorForSceneDelegate {
    func setupScene(with window: UIWindow)
}

extension AppCoordinator: AppCoordinatorForSceneDelegate {
    
    func setupScene(with window: UIWindow) {        
        window.rootViewController = navigationController
    }
    
}

