//
//  BaseViewComponents.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 28.12.2023.
//

import UIKit


protocol BaseViewComponents {
    
    func setupViews(style: UIUserInterfaceStyle, parent: UIView)
    func updateStyle(to style: UIUserInterfaceStyle, parent: UIView, animated: Bool)
    
    func setupLayers(parent: UIView)
    
    func setupConstraints(parent: UIView)
    
}


extension BaseViewComponents {
    
    func setupLayers(parent: UIView) { }
    
}
