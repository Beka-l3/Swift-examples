//
//  MyNavigationController+Presence.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 08.01.2024.
//

import UIKit


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
