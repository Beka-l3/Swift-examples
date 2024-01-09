//
//  SquareHero.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 09.01.2024.
//

import UIKit


enum SquareHero {
    
    static let squareDimension: CGFloat = 60
    
    static let cornerRadius: CGFloat = 8
    
    static let initialSize: CGSize = .init(width: squareDimension, height: squareDimension)
    static let initialOrigin: CGPoint = .init(
        x: GConstants.HIG.Padding.Eight.x2,
        y: AnimationTableViewCell.animationViewHeight / 2 - squareDimension / 2
    )
    
}


extension SquareHero {
    
    static func getSquare(color: UIColor = .systemPurple) -> UIView {
        let view = UIView()
        view.frame = .init(
            origin: SquareHero.initialOrigin,
            size: SquareHero.initialSize
        )
        view.backgroundColor = .systemPurple
        view.layer.cornerRadius = SquareHero.cornerRadius
        return view
    }
    
}


extension SquareHero {
    
    enum CenterPositions {
        
        case leftCenter
        case rightCenter
        
        var asPoint: CGPoint {
            
            switch self {
                
            case .leftCenter:
                return .init(
                    x: GConstants.HIG.Padding.Eight.x2 + squareDimension / 2,
                    y: AnimationTableViewCell.animationViewHeight / 2
                )
                
            case .rightCenter:
                return .init(
                    x: GConstants.HIG.Size.screen.width - GConstants.HIG.Padding.Eight.x2 - squareDimension / 2,
                    y: AnimationTableViewCell.animationViewHeight / 2
                )
                
            }
            
        }
        
    }
    
}
