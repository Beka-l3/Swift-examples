//
//  BAVMultipleSequences+AnimateCombined1.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 13.01.2024.
//

import UIKit


extension BAVMultipleSequences {
    
    func animateCombined1() {
        UIView.animateKeyframes(withDuration: GConstants.Animation.Duration.long, delay: .zero) { [unowned self] in
            
            switch self.state {
                
            case .initail:
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.firstPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.center = SquareHero.CenterPositions.middleTop.asPoint
                    self.square.alpha = SquareHero.AlphaValue.oneThird.rawValue
                    self.square.transform = SquareHero.TransformRotation.twoSeventy.asTransform
                }
                
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.secondPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.center = SquareHero.CenterPositions.middleBottom.asPoint
                    self.square.alpha = SquareHero.AlphaValue.twoThird.rawValue
                    self.square.transform = SquareHero.TransformRotation.oneEighty.asTransform
                }
                
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.thirdPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.center = SquareHero.CenterPositions.rightCenter.asPoint
                    self.square.alpha = SquareHero.AlphaValue.zero.rawValue
                    self.square.transform = SquareHero.TransformRotation.threeSixty.asTransform
                }
                
            case .final:
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.firstPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.center = SquareHero.CenterPositions.middleBottom.asPoint
                    self.square.alpha = SquareHero.AlphaValue.twoThird.rawValue
                    self.square.transform = SquareHero.TransformRotation.oneEighty.asTransform
                }
                
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.secondPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.center = SquareHero.CenterPositions.middleTop.asPoint
                    self.square.alpha = SquareHero.AlphaValue.oneThird.rawValue
                    self.square.transform = SquareHero.TransformRotation.twoSeventy.asTransform
                }
                
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.thirdPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.center = SquareHero.CenterPositions.leftCenter.asPoint
                    self.square.alpha = SquareHero.AlphaValue.one.rawValue
                    self.square.transform = SquareHero.TransformRotation.zero.asTransform
                }
                
            }
            
        } completion: { [unowned self] _ in
            self.isAnimating = false
            self.state = self.state == .initail ? .final : .initail
        }
    }
    
}
