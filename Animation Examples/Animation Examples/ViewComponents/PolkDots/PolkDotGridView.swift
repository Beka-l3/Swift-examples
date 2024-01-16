//
//  PolkDotGridView.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 16.01.2024.
//

import UIKit


final class PolkDotGridView: UIView {
    
    enum PolkDotSize: Int {
        case small = 16
        case medium = 12
        case large = 8
    }
    
    enum AnimationSpeed {
        case fast, medium, slow
    }
    
    
//    MARK: properties
    private(set) var polkDotSize: PolkDotSize
    private(set) var polkDots: [[PolkDotView]] = []
    private(set) var dotsCount: Int = 0
    
    var animatedDotsCount: Int = 0
    var timer: Timer? {
        willSet {
            if newValue == nil {
                timer?.invalidate()
            }
        }
    }
    
    var animationSpeed: AnimationSpeed
    
    
//    MARK: lifecycle
    init(polkDotSize: PolkDotSize = .medium, animationSpeed: AnimationSpeed = .fast) {
        self.polkDotSize = polkDotSize
        self.animationSpeed = animationSpeed
        super.init(frame: GConstants.HIG.Size.screen)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        self.polkDotSize = .medium
        self.animationSpeed = .fast
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
//    MARK: private func
    private func setupView() {
        backgroundColor = .clear
        layer.zPosition = -10
        
        createPolkDotViews()
    }
    
    private func createPolkDotViews() {
        let dotDimension = bounds.width / CGFloat(polkDotSize.rawValue)
        let amountOfRows = Int(bounds.height / dotDimension)
        let offset = (bounds.height - CGFloat(amountOfRows) * dotDimension) / 2
        
        for i in 0..<amountOfRows {
            var dotRow: [PolkDotView] = []
            
            for j in 0..<polkDotSize.rawValue {
                let x = dotDimension * CGFloat(j)
                let y = offset + dotDimension * CGFloat(i)
                
                let dot = PolkDotView(frame: .init(
                    origin: .init(x: x, y: y),
                    size: .init(width: dotDimension, height: dotDimension)
                ))
                
                addSubview(dot)
                dotRow.append(dot)
            }
            
            polkDots.append(dotRow)
        }
        
        dotsCount = amountOfRows * polkDotSize.rawValue
    }
    
}

