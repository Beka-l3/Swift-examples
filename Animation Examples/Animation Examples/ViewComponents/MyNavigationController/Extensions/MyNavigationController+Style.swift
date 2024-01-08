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
    
    private var navbarStyleDark: NavbarStyle {
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
    
    
//    MARK: private func
    private func updateNavbarStyle(animated: Bool, style: NavbarStyle) {
        
        let action = { [unowned self] in
            self.navigationBar.standardAppearance = style.standard
            self.navigationBar.scrollEdgeAppearance = style.scrollEdge
            self.navigationBar.tintColor = style.tintColor
        }
        
        if animated {
            
            UIView.animate(withDuration: 0.6) { [unowned self] in
                self.setNeedsStatusBarAppearanceUpdate()
            }
            
            UIView.transition(with: self.navigationBar, duration: 0.6, animations: action)
            
        } else {
            
            setNeedsStatusBarAppearanceUpdate()
            action()
            
        }
        
    }
    
}
