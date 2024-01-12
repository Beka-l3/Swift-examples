//
//  BaseViewComponents.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 28.12.2023.
//

import UIKit


protocol BaseViewComponents {
    
    func setupViews(parent: UIView)
    
    func setupLayers(parent: UIView)
    
    func setupConstraints(parent: UIView)
    
}


extension BaseViewComponents {
    
    func setupLayers(parent: UIView) { }
    
}
