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
        nextDotToAnimate = (0, 0)
        isAnimating = true
        
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(waveAnimationForTimer), userInfo: nil, repeats: true)
    }
    
    @objc func waveAnimationForTimer() {
        guard animatedDotsCount < dotsCount else {
            timer?.invalidate()
            return
        }
        
        polkDots[nextDotToAnimate.i][nextDotToAnimate.j].blink()
        animatedDotsCount += 1
        nextDotToAnimate = (animatedDotsCount / polkDotSize.rawValue, animatedDotsCount % polkDotSize.rawValue)
    }
    
}
