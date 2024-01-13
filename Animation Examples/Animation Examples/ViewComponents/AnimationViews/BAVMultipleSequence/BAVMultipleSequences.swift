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
