//
//  BAVSingleSequence.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 12.01.2024.
//

import UIKit


/// Example of inheritance of `BasicAnimationView`
final class BAVSingleSequence: BasicAnimationView {
    
    /// override `startAnimation`
    /// Animations with only 1 continuous squence
    override func startAnimation() {
        guard !isAnimating else { return }
        
        isAnimating = true
        
        let animation: () -> Void
        var duration = GConstants.Animation.Duration.AnimationView.fast
        
        switch type {
            
        case .position:
            squreCenterPosition = squreCenterPosition == .leftCenter ? .rightCenter : .leftCenter
            animation = { [unowned self] in
                self.square.center = self.squreCenterPosition.asPoint
            }
            
        case .alpha:
            squreAlphaValue = squreAlphaValue == .one ? .zero : .one
            animation = { [unowned self] in
                self.square.alpha = self.squreAlphaValue.rawValue
            }
            
        case .size:
            squreTransformSize = squreTransformSize == .small ? .large : .small
            animation = { [unowned self] in
                self.square.transform = self.squreTransformSize == .small ? .identity : CGAffineTransform(scaleX: 1.25, y: 1.25)
            }
            
        case .rotation:
            squreTransformRotation = squreTransformRotation == .left ? .right : .left
            animation = { [unowned self] in
                self.square.transform = self.squreTransformRotation == .left ? CGAffineTransform(rotationAngle: 0) : CGAffineTransform(rotationAngle: 3.14)
            }
            
        case .color:
            squareColor = squareColor == .purple ? .yellow : .purple
            animation = { [unowned self] in
                self.square.backgroundColor = self.squareColor.asUIColor
            }
            
        case .combined1:
            squreCenterPosition = squreCenterPosition == .leftCenter ? .rightCenter : .leftCenter
            squreAlphaValue = squreAlphaValue == .one ? .zero : .one
            squreTransformRotation = squreTransformRotation == .left ? .right : .left
            duration = GConstants.Animation.Duration.AnimationView.standard
            animation = { [unowned self] in
                self.square.center = self.squreCenterPosition.asPoint
                self.square.alpha = self.squreAlphaValue.rawValue
                self.square.transform = self.squreTransformRotation == .left ? CGAffineTransform(rotationAngle: 0) : CGAffineTransform(rotationAngle: 3.14)
            }
            
        case .combined2:
            squreCenterPosition = squreCenterPosition == .leftCenter ? .rightCenter : .leftCenter
            squareColor = squareColor == .purple ? .yellow : .purple
            squreTransformSize = squreTransformSize == .small ? .large : .small
            duration = GConstants.Animation.Duration.AnimationView.standard
            animation = { [unowned self] in
                self.square.center = self.squreCenterPosition.asPoint
                self.square.backgroundColor = self.squareColor.asUIColor
                self.square.transform = self.squreTransformSize == .small ? .identity : self.square.transform.scaledBy(x: 1.25, y: 1.25)
            }
            
        case .none:
            animation = { }
            
        }
        
        if type != .none {
            UIView.animate(withDuration: duration, animations: animation) { [unowned self] _ in
                self.isAnimating = false
            }
        }
        
    }
    
}

