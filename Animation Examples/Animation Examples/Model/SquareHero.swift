//
//  SquareHero.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 09.01.2024.
//

import UIKit


enum SquareHero {
    
    static let squareDimension: CGFloat = 96
    
    static let initialSize: CGSize = .init(width: squareDimension, height: squareDimension)
    static let initialOrigin: CGPoint = .init(x: GConstants.HIG.Padding.Eight.x2 + squareDimension / 2, y: AnimationTableViewCell.animationViewHeight / 2)
    
}
