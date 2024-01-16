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
        var duration = GConstants.Animation.Duration.short
        
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
                self.square.transform = self.squreTransformSize.asTransform
            }
            
        case .rotation:
            squreTransformRotation = squreTransformRotation == .zero ? .threeSixty : .zero
            animation = { [unowned self] in
                self.square.transform = self.squreTransformRotation.asTransform
            }
            
        case .color:
            squareColor = squareColor == .purple ? .yellow : .purple
            animation = { [unowned self] in
                self.square.backgroundColor = self.squareColor.asUIColor
            }
            
        case .combined1:
            squreCenterPosition = squreCenterPosition == .leftCenter ? .rightCenter : .leftCenter
            squreAlphaValue = squreAlphaValue == .one ? .zero : .one
            squreTransformRotation = squreTransformRotation == .zero ? .threeSixty : .zero
            duration = GConstants.Animation.Duration.long
            animation = { [unowned self] in
                self.square.center = self.squreCenterPosition.asPoint
                self.square.alpha = self.squreAlphaValue.rawValue
                self.square.transform = self.squreTransformRotation.asTransform
            }
            
        case .combined2:
            squreCenterPosition = squreCenterPosition == .leftCenter ? .rightCenter : .leftCenter
            squareColor = squareColor == .purple ? .yellow : .purple
            squreTransformSize = squreTransformSize == .small ? .large : .small
            duration = GConstants.Animation.Duration.long
            animation = { [unowned self] in
                self.square.center = self.squreCenterPosition.asPoint
                self.square.backgroundColor = self.squareColor.asUIColor
                self.square.transform = self.squreTransformSize.asTransform
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

