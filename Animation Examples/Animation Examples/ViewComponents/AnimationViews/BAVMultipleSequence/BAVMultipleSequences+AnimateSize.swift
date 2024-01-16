//
//  BAVMultipleSequences+AnimateSize.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 13.01.2024.
//

import UIKit


extension BAVMultipleSequences {

    func animateSize() {
        UIView.animateKeyframes(withDuration: GConstants.Animation.Duration.medium, delay: .zero) { [unowned self] in
            
            switch self.state {
                
            case .initail:
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.firstPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.transform = SquareHero.TransformSize.middle2.asTransform
                }
                
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.secondPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.transform = SquareHero.TransformSize.middle1.asTransform
                }
                
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.thirdPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.transform = SquareHero.TransformSize.large.asTransform
                }
                
            case .final:
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.firstPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.transform = SquareHero.TransformSize.middle1.asTransform
                }
                
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.secondPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.transform = SquareHero.TransformSize.middle2.asTransform
                }
                
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.thirdPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.transform = SquareHero.TransformSize.small.asTransform
                }
                
            }
            
        } completion: { [unowned self] _ in
            self.isAnimating = false
            self.state = self.state == .initail ? .final : .initail
        }
    }
    
}
