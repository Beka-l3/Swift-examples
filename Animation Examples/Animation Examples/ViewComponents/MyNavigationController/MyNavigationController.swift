//
//  MyNavigationController.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 08.01.2024.
//

import UIKit


final class MyNavigationController: UINavigationController {
    
    private var statusBarStyle: UIStatusBarStyle = . default
    
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


// MARK: style
extension MyNavigationController {
    
    func setLightNavbarStyle(animated: Bool = true) {
        statusBarStyle = .darkContent
        setNeedsStatusBarAppearanceUpdate()
        navigationBar.standardAppearance = navbarStyleLight.standard
        navigationBar.scrollEdgeAppearance = navbarStyleLight.scrollEdge
        navigationBar.tintColor = navbarStyleLight.tintColor
    }
    
    func setDarkNavbarStyle(animated: Bool = true) {
        statusBarStyle = .lightContent
        setNeedsStatusBarAppearanceUpdate()
        navigationBar.standardAppearance = navbarStyleDark.standard
        navigationBar.scrollEdgeAppearance = navbarStyleDark.scrollEdge
        navigationBar.tintColor = navbarStyleDark.tintColor
    }
    
    
//    MARK: private properties
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


// MARK: Appearance
extension MyNavigationController {
    
    func appearNavbar(animated: Bool = true) {
        if animated {
            
            UIView.animate(withDuration: 0.6) { [unowned self] in
                self.navigationBar.alpha = 1
            }
            
        } else {
            
            navigationBar.alpha = 1
            
        }
    }
    
    func disappearNavbar(animated: Bool = false) {
        if animated {
            
            UIView.animate(withDuration: GConstants.Animation.Duration.Splash.part2) { [unowned self] in
                self.navigationBar.alpha = 0
            }
            
        } else {
            
            navigationBar.alpha = 0
            
        }
    }
    
}
