//
//  UIStyle.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 09.01.2024.
//

import UIKit


protocol UIStyler {
    
    func setStyle(_ style: UIUserInterfaceStyle, animated: Bool)
    
    func setStyle(_ style: UIUserInterfaceStyle, parent: UIView, animated: Bool)
    
}


extension UIStyler {
    
    func setStyle(_ style: UIUserInterfaceStyle, animated: Bool) {
        
    }
    
    func setStyle(_ style: UIUserInterfaceStyle, parent: UIView, animated: Bool) {
        
    }
    
}
