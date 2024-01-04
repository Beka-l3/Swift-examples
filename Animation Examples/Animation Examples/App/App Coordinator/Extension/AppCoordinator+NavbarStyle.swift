//
//  AppCoordinator+NavbarStyle.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 30.12.2023.
//

import UIKit


extension AppCoordinator {
    
    var isLargeNavTitle: Bool {
        get {
            navigationController.navigationBar.prefersLargeTitles
        }
        
        set {
            navigationController.navigationBar.prefersLargeTitles = newValue
        }
    }
    
    func setDefaultNavbarStyle() {
        navigationController.navigationItem.hidesBackButton = true
        navigationController.isNavigationBarHidden = false
        navigationController.navigationBar.tintColor = .white
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
        appearance.backgroundColor = .clear
        appearance.largeTitleTextAttributes = largeTitleAttr
        appearance.titleTextAttributes = titleAttr
        
        let largeAppearance = UINavigationBarAppearance()
//        largeAppearance.backgroundEffect = nil
        largeAppearance.backgroundEffect = blurEffect
        largeAppearance.backgroundColor = UIColor(white: 1, alpha: 0.2)
        largeAppearance.shadowColor = .clear
        largeAppearance.largeTitleTextAttributes = largeTitleAttr
        largeAppearance.titleTextAttributes = titleAttr
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = largeAppearance
    }
    
    func navBarStyle1() {
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let largeTitleAttr = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 36)
        ]
        let titleAttr = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22)
        ]
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundEffect = blurEffect
        appearance.backgroundColor = UIColor(red: 0.2, green: 0.7, blue: 0.7, alpha: 0.3)
        appearance.largeTitleTextAttributes = largeTitleAttr
        appearance.titleTextAttributes = titleAttr
        
        let largeAppearance = UINavigationBarAppearance()
        largeAppearance.backgroundEffect = blurEffect
        largeAppearance.backgroundColor = UIColor(red: 0.2, green: 0.7, blue: 0.7, alpha: 0.3)
        largeAppearance.shadowColor = .clear
        largeAppearance.largeTitleTextAttributes = largeTitleAttr
        largeAppearance.titleTextAttributes = titleAttr
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = largeAppearance
        
    }
    
    func appearNavbar(animated: Bool = true) {
        
        if animated {
            
            UIView.animate(withDuration: 0.6) { [unowned self] in
                self.navigationController.navigationBar.alpha = 1
            }
            
        } else {
            
            navigationController.navigationBar.alpha = 1
            
        }
        
    }
    
    func disappearNavbar(animated: Bool = false) {
        
        if animated {
            
            UIView.animate(withDuration: GConstants.Animation.Duration.Splash.part2) { [unowned self] in
                self.navigationController.navigationBar.alpha = 0
            }
            
        } else {
            
            navigationController.navigationBar.alpha = 0
            
        }
        
    }
    
}

