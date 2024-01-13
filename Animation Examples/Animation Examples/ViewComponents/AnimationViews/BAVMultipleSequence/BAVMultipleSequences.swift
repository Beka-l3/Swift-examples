//
//  BAVMultipleSequences.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 13.01.2024.
//

import UIKit


final class BAVMultipleSequences: BasicAnimationView {
    
    
    override func startAnimation() {
        guard !isAnimating else { return }
        
        isAnimating = true
        
        switch type {
            
        case .position:
            animatePosition()
            
        case .alpha:
            animateAlpha()
            
        case .size:
            animateSize()
            
        case .rotation:
            animateRotation()
            
        case .color:
            animateColor()
            
        case .combined1:
            animateCombined1()
            
        case .combined2:
            animateCombined2()
            
        case .none:
            break
            
        }
        
    }
    
    
}


extension BAVMultipleSequences {

    func animateSize() {
        UIView.animateKeyframes(withDuration: GConstants.Animation.Duration.medium, delay: .zero) { [unowned self] in
            
            switch self.state {
                
            case .initail:
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.firstPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                }
                
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.secondPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                }
                
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.thirdPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
                }
                
            case .final:
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.firstPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                }
                
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.secondPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                }
                
                UIView.addKeyframe(withRelativeStartTime: GConstants.Animation.Duration.Triplet.thirdPartStart, relativeDuration: GConstants.Animation.Duration.Triplet.unit) {
                    self.square.transform = .identity
                }
                
            }
            
        } completion: { [unowned self] _ in
            self.isAnimating = false
            self.state = self.state == .initail ? .final : .initail
        }
    }
    
}

extension BAVMultipleSequences {

    func animateRotation() {
        
    }
    
}

extension BAVMultipleSequences {

    func animateColor() {
        
    }
    
}

extension BAVMultipleSequences {

    func animateCombined1() {
        
    }
    
}


extension BAVMultipleSequences {

    func animateCombined2() {
        
    }
    
}
