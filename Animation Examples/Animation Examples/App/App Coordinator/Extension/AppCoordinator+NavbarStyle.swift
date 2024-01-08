//
//  AppCoordinator+NavbarStyle.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 30.12.2023.
//

import UIKit


extension AppCoordinator {
    
//    MARK: exposed properties
    var isLargeNavTitle: Bool {
        get {
            navigationController.navigationBar.prefersLargeTitles
        }
        
        set {
            navigationController.navigationBar.prefersLargeTitles = newValue
        }
    }
    
    
//    MARK: exposed func
    func setupNavbar() {
        navigationController.isNavigationBarHidden = true
        updateNavbarStyle(to: navigationController.traitCollection.userInterfaceStyle)
    }
    
    func updateNavbarStyle(to style: UIUserInterfaceStyle) {
        switch style {
            
        case .dark:
            navigationController.setDarkNavbarStyle()
            
        case .light:
            navigationController.setLightNavbarStyle()
            
        case .unspecified:
            break
            
        @unknown default:
            break
        }
    }
    
    func appearNavbar(animated: Bool = true) {
        navigationController.appearNavbar(animated: animated)
    }
    
    func disappearNavbar(animated: Bool = false) {
        navigationController.disappearNavbar(animated: animated)
    }
    
}

