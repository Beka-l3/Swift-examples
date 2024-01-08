//
//  Calculator.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 05.01.2024.
//

import UIKit


struct Calculator {
    
}


extension Calculator {
    
    func calculateHeight(for rootVCTableViewCell: AnimatoinViewControllerDetails) -> CGFloat {
        
        let label = UILabel()
        label.text = rootVCTableViewCell.description
        label.font = Fonts.callout
        label.numberOfLines = .zero
        
        let size = label.sizeThatFits(.init(width: GConstants.HIG.Size.screen.width - GConstants.HIG.Padding.Four.x11, height: .infinity))
        let rows = (size.height / Fonts.Height.callout).rounded()
        
        switch rows {
            
        case 0 ... 1:
            return 58
            
        case 2:
            return 78
        
        default:
            return 96
            
        }
        
    }
    
}
