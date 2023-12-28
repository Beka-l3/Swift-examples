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
    }
    
    
    
}


extension AppCoordinator: AppCoordinatorForSceneDelegate {
    
    func setupScene(with window: UIWindow) {        
        window.rootViewController = navigationController
    }
    
}
