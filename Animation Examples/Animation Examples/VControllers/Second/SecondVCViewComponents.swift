//
//  SecondVCViewComponents.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 13.01.2024.
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
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                self.dot.alpha = .zero
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.dot.alpha = 1
            }
        }
    }
    
    
//    MARK: private func
    private func setupDot() {
        let dimension = frame.size.width
        let dotDimension = dimension - GConstants.HIG.Padding.Four.x1
        
        dot.frame.size = .init(width: dotDimension, height: dotDimension)
        dot.center = .init(x: dimension / 2, y: dimension / 2)
        
        dot.backgroundColor = UIColor(white: 1, alpha: 0.87)
        dot.layer.cornerRadius = dotDimension / 2
        
        addSubview(dot)
    }
    
}


final class PolkDotsGridView: UIView {
    
    enum PolkDotSize: Int {
        case small = 16
        case medium = 12
        case large = 8
    }
    
    
//    MARK: properties
    var polkDotSize: PolkDotSize
    var polkDots: [[PolkDotView]] = []
    
    
//    MARK: lifecycle
    init(polkDotSize: PolkDotSize = .medium) {
        self.polkDotSize = polkDotSize
        super.init(frame: GConstants.HIG.Size.screen)
        createPolkDotViews()
    }
    
    required init?(coder: NSCoder) {
        self.polkDotSize = .medium
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
//    MARK: private func
    private func createPolkDotViews() {
        let dotDimension = bounds.width / CGFloat(polkDotSize.rawValue)
        let amountOfRows = Int(bounds.height) / polkDotSize.rawValue
        let offset = (bounds.height - CGFloat(amountOfRows * polkDotSize.rawValue)) / 2
        
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
        
    }
    
}


final class SecondVCViewComponents {
    
    private lazy var gridOfPolkDots = PolkDotsGridView(polkDotSize: .small)
    
}


extension SecondVCViewComponents: BaseViewComponents {
    
    func setupViews(parent: UIView) {
        parent.addSubview(gridOfPolkDots)
        
        setupConstraints(parent: parent)
    }
}


extension SecondVCViewComponents: UIStyler {
    
    func setStyle(_ style: UIUserInterfaceStyle = .dark, parent: UIView, animated: Bool = true) {
        
        if animated {
            
            UIView.animate(withDuration: GConstants.Animation.Duration.standard) { [unowned parent] in
                parent.backgroundColor = style == .light ? .white : .black
            }
            
        } else  {
            
            parent.backgroundColor = style == .light ? .white : .black
            
        }
        
    }
    
}


extension SecondVCViewComponents {
    
    func setupConstraints(parent: UIView) {
        NSLayoutConstraint.activate([
            gridOfPolkDots.topAnchor.constraint(equalTo: parent.topAnchor),
            gridOfPolkDots.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            gridOfPolkDots.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
            gridOfPolkDots.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
        ])
    }
    
}
