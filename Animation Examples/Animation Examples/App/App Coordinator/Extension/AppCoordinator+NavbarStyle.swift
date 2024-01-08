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
        navigationController.isNavigationBarHidden = false
        updateNavbarStyle(to: navigationController.traitCollection.userInterfaceStyle)
    }
    
    func updateNavbarStyle(to style: UIUserInterfaceStyle) {
        switch style {
            
        case .dark:
            setDarkNavbarStyle()
            
        case .light:
            setLightNavbarStyle()
            
        case .unspecified:
            break
            
        @unknown default:
            break
        }
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
    
    
//    MARK: private func
    private func setLightNavbarStyle() {
        navigationController.navigationBar.standardAppearance = navbarStyleLight.standard
        navigationController.navigationBar.scrollEdgeAppearance = navbarStyleLight.scrollEdge
        navigationController.navigationBar.tintColor = navbarStyleLight.tintColor
    }
    
    private func setDarkNavbarStyle() {
        navigationController.navigationBar.standardAppearance = navbarStyleDark.standard
        navigationController.navigationBar.scrollEdgeAppearance = navbarStyleDark.scrollEdge
        navigationController.navigationBar.tintColor = navbarStyleDark.tintColor
    }
    
    private var navbarStyleLight: (standard: UINavigationBarAppearance, scrollEdge: UINavigationBarAppearance, tintColor: UIColor) {
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
        largeAppearance.backgroundEffect = blurEffect
        largeAppearance.backgroundColor = .clear
        largeAppearance.shadowColor = .clear
        largeAppearance.largeTitleTextAttributes = largeTitleAttr
        largeAppearance.titleTextAttributes = titleAttr
        
        return (appearance, largeAppearance, .black)
    }
    
    private var navbarStyleDark: (standard: UINavigationBarAppearance, scrollEdge: UINavigationBarAppearance, tintColor: UIColor) {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
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
        appearance.backgroundColor = UIColor(white: 0, alpha: 0.2)
        appearance.largeTitleTextAttributes = largeTitleAttr
        appearance.titleTextAttributes = titleAttr
        
        let largeAppearance = UINavigationBarAppearance()
        largeAppearance.backgroundEffect = blurEffect
        largeAppearance.backgroundColor = .clear
        largeAppearance.shadowColor = .clear
        largeAppearance.largeTitleTextAttributes = largeTitleAttr
        largeAppearance.titleTextAttributes = titleAttr
        
        return (appearance, largeAppearance, .white)
    }
    
}

