//
//  MyNavigationController.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 08.01.2024.
//

import UIKit


final class MyNavigationController: UINavigationController {
    
    var statusBarStyle: UIStatusBarStyle = . default
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
//        topViewController?.preferredStatusBarStyle ?? .default
        statusBarStyle
    }
    
    
//    MARK: lifecycle
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        switch traitCollection.userInterfaceStyle {
        
        case .light:
            setLightNavbarStyle()
        
        case .dark:
            setDarkNavbarStyle()
            
        case .unspecified:
            break
        
        @unknown default:
            break
            
        }
    }
    
}

