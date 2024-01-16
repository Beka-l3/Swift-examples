//
//  BAVMultipleSequences+AnimateCombined2.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 13.01.2024.
//

import UIKit


extension BAVMultipleSequences {
    
    func animateCombined2() {
        UIView.animateKeyframes(withDuration: GConstants.Animation.Duration.long, delay: .zero) { [unowned self] in
            
            switch self.state {
                
            case .initail:
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.firstPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.center = SquareHero.CenterPositions.middleTop.asPoint
                    self.square.backgroundColor = SquareHero.Color.yellow.asUIColor
                    self.square.transform = SquareHero.TransformSize.middle2.asTransform
                }
                
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.secondPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.center = SquareHero.CenterPositions.middleBottom.asPoint
                    self.square.backgroundColor = SquareHero.Color.blue.asUIColor
                    self.square.transform = SquareHero.TransformSize.middle1.asTransform
                }
                
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.thirdPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.center = SquareHero.CenterPositions.rightCenter.asPoint
                    self.square.backgroundColor = SquareHero.Color.pink.asUIColor
                    self.square.transform = SquareHero.TransformSize.large.asTransform
                }
                
            case .final:
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.firstPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.center = SquareHero.CenterPositions.middleBottom.asPoint
                    self.square.backgroundColor = SquareHero.Color.blue.asUIColor
                    self.square.transform = SquareHero.TransformSize.middle1.asTransform
                }
                
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.secondPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.center = SquareHero.CenterPositions.middleTop.asPoint
                    self.square.backgroundColor = SquareHero.Color.yellow.asUIColor
                    self.square.transform = SquareHero.TransformSize.middle2.asTransform
                }
                
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.thirdPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.center = SquareHero.CenterPositions.leftCenter.asPoint
                    self.square.backgroundColor = SquareHero.Color.purple.asUIColor
                    self.square.transform = SquareHero.TransformSize.small.asTransform
                }
                
            }
            
        } completion: { [unowned self] _ in
            self.isAnimating = false
            self.state = self.state == .initail ? .final : .initail
        }
    }
    
}

