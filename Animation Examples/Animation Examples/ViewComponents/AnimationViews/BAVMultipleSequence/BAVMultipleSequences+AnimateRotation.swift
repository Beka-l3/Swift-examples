//
//  BAVMultipleSequences+AnimateRotation.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 13.01.2024.
//

import UIKit


extension BAVMultipleSequences {
    
    func animateRotation() {
        UIView.animateKeyframes(withDuration: GConstants.Animation.Duration.medium, delay: .zero) { [unowned self] in
            
            switch self.state {
                
            case .initail:
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.firstPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.transform = SquareHero.TransformRotation.twoSeventy.asTransform
                }
                
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.secondPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.transform = SquareHero.TransformRotation.oneEighty.asTransform
                }
                
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.thirdPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.transform = SquareHero.TransformRotation.threeSixty.asTransform
                }
                
            case .final:
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.firstPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.transform = SquareHero.TransformRotation.oneEighty.asTransform
                }
                
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.secondPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.transform = SquareHero.TransformRotation.twoSeventy.asTransform
                }
                
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.thirdPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.transform = SquareHero.TransformRotation.zero.asTransform
                }
                
            }
            
        } completion: { [unowned self] _ in
            self.isAnimating = false
            self.state = self.state == .initail ? .final : .initail
        }
        
        
    }
    
}
