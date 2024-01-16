//
//  PolkDotView.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 16.01.2024.
//

import UIKit


final class PolkDotView: UIView {
    
    lazy var dot = UIView()
    
    
//    MARK: lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupDot()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
//    MARK: exposed func
    func blink(duration: TimeInterval = GConstants.Animation.Duration.short) {
        UIView.animateKeyframes(withDuration: duration, delay: .zero) { [unowned self] in
            UIView.addKeyframe(withRelativeStartTime: .zero, relativeDuration: .halfSecond) {
                self.dot.alpha = .zero
            }
            
            UIView.addKeyframe(withRelativeStartTime: .halfSecond, relativeDuration: .halfSecond) {
                self.dot.alpha = 1
            }
        }
    }
    
    
//    MARK: private func
    private func setupDot() {
        let dimension = frame.size.width
        let dotDimension = dimension - GConstants.HIG.Padding.Four.x2
        
        dot.frame.size = .init(width: dotDimension, height: dotDimension)
        dot.center = .init(x: dimension / 2, y: dimension / 2)
        
        dot.backgroundColor = UIColor(white: 1, alpha: 0.87)
        dot.layer.cornerRadius = dotDimension / 2
        
        addSubview(dot)
    }
    
}

