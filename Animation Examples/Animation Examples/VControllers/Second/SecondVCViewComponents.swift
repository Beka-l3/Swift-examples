//
//  SecondVCViewComponents.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 13.01.2024.
//

import UIKit


final class SecondVCViewComponents {
    
    
    
}


extension SecondVCViewComponents: BaseViewComponents {
    
    func setupViews(parent: UIView) {
//        parent.addSubview(animationTableView)
        
        setupConstraints(parent: parent)
    }
}


extension SecondVCViewComponents: UIStyler {
    
    func setStyle(_ style: UIUserInterfaceStyle = .dark, parent: UIView, animated: Bool = true) {
        
        if animated {
            
            UIView.animate(withDuration: GConstants.Animation.Duration.standard) { [unowned parent] in
                parent.backgroundColor = style == .light ? .white : .black
            }
            
        } else  {
            
            parent.backgroundColor = style == .light ? .white : .black
            
        }
        
    }
    
}


extension SecondVCViewComponents {
    
    func setupConstraints(parent: UIView) {
        NSLayoutConstraint.activate([
            
        ])
    }
    
}
