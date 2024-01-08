//
//  MyNavigationController+Style.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 08.01.2024.
//

import UIKit


extension MyNavigationController {
    
    func setLightNavbarStyle(animated: Bool = true) {
        statusBarStyle = .darkContent
        updateNavbarStyle(animated: animated, style: navbarStyleLight)
    }
    
    func setDarkNavbarStyle(animated: Bool = true) {
        statusBarStyle = .lightContent
        updateNavbarStyle(animated: animated, style: navbarStyleDark)
    }
    
    
//    MARK: private properties
    
    private typealias NavbarStyle = (standard: UINavigationBarAppearance, scrollEdge: UINavigationBarAppearance, tintColor: UIColor)
    
    private var navbarStyleLight: NavbarStyle {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let largeTitleAttr = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: Fonts.titleLarge
        ]
        let titleAttr = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: Fonts.title2
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
    
    private var navbarStyleDark: NavbarStyle {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let largeTitleAttr = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: Fonts.titleLarge
        ]
        let titleAttr = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: Fonts.title2
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
    
    
//    MARK: private func
    private func updateNavbarStyle(animated: Bool, style: NavbarStyle) {
        
        let action = { [unowned self] in
            self.navigationBar.standardAppearance = style.standard
            self.navigationBar.scrollEdgeAppearance = style.scrollEdge
            self.navigationBar.tintColor = style.tintColor
        }
        
        if animated {
            
            UIView.animate(withDuration: GConstants.Animation.Duration.MyNavigationController.updateStyle) { [unowned self] in
                self.setNeedsStatusBarAppearanceUpdate()
            }
            
            UIView.transition(with: view, duration: GConstants.Animation.Duration.MyNavigationController.updateStyle, animations: action)
            
        } else {
            
            setNeedsStatusBarAppearanceUpdate()
            action()
            
        }
        
    }
    
}
