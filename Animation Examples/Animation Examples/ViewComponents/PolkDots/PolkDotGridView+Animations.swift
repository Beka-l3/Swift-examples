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
        
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(waveAnimationForTimer), userInfo: nil, repeats: true)
    }
    
    @objc func waveAnimationForTimer() {
        guard 0 <= animatedDotsCount && animatedDotsCount < dotsCount else {
            timer = nil
            return
        }
        
        polkDots[nextDotToAnimate.i][nextDotToAnimate.j].blink()
        animatedDotsCount += 1
    }
    
    
    private var nextDotToAnimate: (i: Int, j: Int) {
        (animatedDotsCount / polkDotSize.rawValue, animatedDotsCount % polkDotSize.rawValue)
    }
    
    private var isAnimating: Bool {
        timer != nil
    }
    
}
