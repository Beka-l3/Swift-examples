//
//  PolkDotGridView+WaveAnimation.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 16.01.2024.
//

import UIKit


extension PolkDotGridView {
    
    func waveAnimation() {
        guard !isAnimating else { return }
        
        animatedDotsCount = 0
        radiusForWaveAnimation = 0
        
        timer = Timer.scheduledTimer(timeInterval: waveAnimationSpeed, target: self, selector: #selector(waveAnimationForTimer), userInfo: nil, repeats: true)
    }
    
    @objc func waveAnimationForTimer() {
        guard 0 <= animatedDotsCount && animatedDotsCount < totalPolkDotsCount else {
            timer = nil
            return
        }
        
        
        for dot in dotsToAnimate {
            dot.blink(duration: blinkDurationForWaveAnimation)
        }
        
        animatedDotsCount += dotsToAnimate.count
        
        radiusForWaveAnimation += 1
    }
    
    
    private var centerDotCoordinates: (i: Int, j: Int) {
        return (polkDots.count / 2, polkDotSize.rawValue / 2)
    }
    
    private var dotsToAnimate: Set<PolkDotView> {
        guard 0 <= radiusForWaveAnimation, !polkDots.isEmpty else {
            return []
        }
        
        var result: Set<PolkDotView> = []
        
        let topLeftIdx: (i: Int, j: Int) = (max(centerDotCoordinates.i - radiusForWaveAnimation, 0), max(centerDotCoordinates.j - radiusForWaveAnimation, 0))
        let topRightIdx: (i: Int, j: Int) = (max(centerDotCoordinates.i - radiusForWaveAnimation, 0), min(centerDotCoordinates.j + radiusForWaveAnimation, polkDotSize.rawValue - 1))
        
        let bottomLeftIdx: (i: Int, j: Int) = (min(centerDotCoordinates.i + radiusForWaveAnimation, polkDots.count - 1), max(centerDotCoordinates.j - radiusForWaveAnimation, 0))
        let bottomRightIdx: (i: Int, j: Int) = (min(centerDotCoordinates.i + radiusForWaveAnimation, polkDots.count - 1), min(centerDotCoordinates.j + radiusForWaveAnimation, polkDotSize.rawValue - 1))
        
        
        /// top dots
        if centerDotCoordinates.i - radiusForWaveAnimation >= 0 {
            for j in topLeftIdx.j...topRightIdx.j {
                result.insert( polkDots[topLeftIdx.i][j] )
            }
        }
        
        /// bottom dots
        if centerDotCoordinates.i + radiusForWaveAnimation < polkDots.count {
            for j in bottomLeftIdx.j...bottomRightIdx.j {
                result.insert( polkDots[bottomLeftIdx.i][j] )
            }
        }
        
        /// left dots
        if centerDotCoordinates.j - radiusForWaveAnimation >= 0 {
            for i in topLeftIdx.i...bottomLeftIdx.i {
                result.insert( polkDots[i][bottomLeftIdx.j] )
            }
        }
        
        /// right dots
        if centerDotCoordinates.j + radiusForWaveAnimation < polkDotSize.rawValue {
            for i in topRightIdx.i...bottomRightIdx.i {
                result.insert( polkDots[i][bottomRightIdx.j] )
            }
        }
        
        return result
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
        
    private var isAnimating: Bool {
        timer != nil
    }
    
}
