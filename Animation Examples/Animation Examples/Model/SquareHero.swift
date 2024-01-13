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
    
}


extension SquareHero {
    
    static func getSquare(color: UIColor = .systemPurple, centerPosition: CenterPositions = .leftCenter) -> UIView {
        let view = UIView()
        
        view.frame = .init(
            origin: .zero,
            size: SquareHero.initialSize
        )
        
        view.backgroundColor = .systemPurple
        view.layer.cornerRadius = SquareHero.cornerRadius
        
        view.center = centerPosition.asPoint
        
        return view
    }
    
}


extension SquareHero {
    
    enum CenterPositions {
        
        case leftCenter, rightCenter
        case middleTop, middleBottom
        
        var asPoint: CGPoint {
            
            switch self {
                
            case .leftCenter:
                return .init(
                    x: GConstants.HIG.Padding.Eight.x3 + squareDimension / 2,
                    y: AnimationTableViewCell.animationViewHeight / 2
                )
                
            case .rightCenter:
                return .init(
                    x: GConstants.HIG.Size.screen.width - GConstants.HIG.Padding.Eight.x3 - squareDimension / 2,
                    y: AnimationTableViewCell.animationViewHeight / 2
                )
                
            case .middleTop:
                return .init(
                    x: GConstants.HIG.Size.screen.width / 2,
                    y: GConstants.HIG.Padding.Eight.x1 + squareDimension / 2
                )
                
            case .middleBottom:
                return .init(
                    x: GConstants.HIG.Size.screen.width / 2,
                    y: GConstants.HIG.Size.animationTableViewCell.height - (GConstants.HIG.Padding.Eight.x1 + squareDimension / 2)
                )
                
            }
            
        }
        
    }
}


extension SquareHero {
    
    enum AlphaValue: CGFloat {
        
        case zero = 0
        case one = 1
        
        case oneThird = 0.38
        case twoThird = 0.6
        
    }
    
}


extension SquareHero {
 
    enum TransformSize {
        
        case small
        case large
        
    }
    
}


extension SquareHero {
 
    enum TransformRotation {
        
        case right
        case left
        
    }
    
}


extension SquareHero {
 
    enum Color {
        
        case purple
        case yellow
        
        var asUIColor: UIColor {
            
            switch self {
                
            case .purple:
                return .systemPurple
            
            case .yellow:
                return .systemYellow
            
            }
            
        }
    }
    
}
