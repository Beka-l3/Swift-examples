//
//  PolkDotGridView+Animations.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 16.01.2024.
//

import UIKit


extension PolkDotGridView {
    
    func waveAnimation() {
        guard !isAnimating else { return }
        
        animatedDotsCount = 0
        
        timer = Timer.scheduledTimer(timeInterval: waveAnimationSpeed, target: self, selector: #selector(waveAnimationForTimer), userInfo: nil, repeats: true)
    }
    
    @objc func waveAnimationForTimer() {
        guard 0 <= animatedDotsCount && animatedDotsCount < dotsCount else {
            timer = nil
            return
        }
        
        polkDots[nextDotToAnimate.i][nextDotToAnimate.j].blink(duration: blinkDurationForWaveAnimation)
        animatedDotsCount += 1
    }
    
    
    private var waveAnimationSpeed: TimeInterval {
        switch animationSpeed {
            
        case .fast:
            return 0.05
            
        case .medium:
            return 0.2
            
        case .slow:
            return 0.6
            
        }
    }
    
    private var blinkDurationForWaveAnimation: TimeInterval {
        
        switch animationSpeed {
            
        case .fast:
            return GConstants.Animation.Duration.short
            
        case .medium:
            return GConstants.Animation.Duration.medium
            
        case .slow:
            return GConstants.Animation.Duration.long
            
        }
        
    }
    
    private var nextDotToAnimate: (i: Int, j: Int) {
        (animatedDotsCount / polkDotSize.rawValue, animatedDotsCount % polkDotSize.rawValue)
    }
    
    private var isAnimating: Bool {
        timer != nil
    }
    
}
