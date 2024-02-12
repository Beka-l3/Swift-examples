//
//  BgGradients.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 12.02.2024.
//

import UIKit


enum BgGradients: CaseIterable {
    case basic, blue, darkBlue, red, yellow
    
    
    var asColors: [UIColor] {
        switch self {
            
        case .basic:
            return [
                UIColor(red: 245/255, green: 174/255, blue: 76/255, alpha: 1),
                UIColor(red: 241/255, green: 89/255, blue: 41/255, alpha: 1)
            ]
            
        case .blue:
            return [.systemBlue, .systemGray]
            
        case .darkBlue:
            return [.systemPurple, .systemBlue]
            
        case .red:
            return [.systemRed, .systemOrange]
            
        case .yellow:
            return [.systemYellow, .systemMint]
            
        }
    }
    
    var asLayer: CAGradientLayer {
        getGradient(with: asColors)
    }
    
    private func getGradient(with colors: [UIColor]) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.type = .axial
        layer.colors = colors.map { $0.cgColor }
        layer.zPosition = 0
        layer.startPoint = .init(x: 0, y: 0)
        layer.endPoint = .init(x: 1, y: 0)
        return layer
    }
}

