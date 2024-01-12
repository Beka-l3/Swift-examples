//
//  BAVCombined1.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 12.01.2024.
//

import UIKit


final class BAVCombined1: UIView {
    

//    MARK: exposed properties
    var isDescriptionHidden: Bool {
        didSet {
            UIView.animate(withDuration: GConstants.Animation.Duration.standard) { [unowned self] in
                self.descriptionLabel.alpha = isDescriptionHidden ? 0 : 1
            }
        }
    }
    
    var squreCenterPosition: SquareHero.CenterPositions = .leftCenter
    var squreAlphaValue: SquareHero.AlphaValue = .one
    var squreTransformRotation: SquareHero.TransformRotation = .right
    
    
//    MARK: private properties
    private var isAnimating: Bool = false
    
    private var descriptionText = Constants.descriptionTextPrefix {
        didSet {
            descriptionLabel.text = descriptionText
        }
    }
    
    
//    MARK: viewComponents
    lazy var square: UIView = SquareHero.getSquare(centerPosition: .leftCenter)
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = descriptionText
        label.font = Fonts.subheadlineBlack
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
//    MARK: lifecycle
    init(isDescriptionHidden: Bool = false) {
        self.isDescriptionHidden = isDescriptionHidden
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        self.isDescriptionHidden = true
        super.init(coder: coder)
    }
    
    
//    MARK: private func
    private func setupView() {
        setupFrame()
        
        addSubview(descriptionLabel)
        addSubview(square)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: GConstants.HIG.Padding.Four.x2),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: GConstants.HIG.Padding.Eight.x2 + SquareHero.squareDimension + GConstants.HIG.Padding.Four.x2),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(GConstants.HIG.Padding.Eight.x2 + SquareHero.squareDimension + GConstants.HIG.Padding.Four.x2)),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -GConstants.HIG.Padding.Four.x2),
        ])
        
        descriptionLabel.text = descriptionText
    }
    
}


extension BAVCombined1: AnimationView {
    
    func startAnimation() {
        guard !isAnimating else { return }
        
        isAnimating = true
        squreCenterPosition = squreCenterPosition == .leftCenter ? .rightCenter : .leftCenter
        squreAlphaValue = squreAlphaValue == .one ? .zero : .one
        squreTransformRotation = squreTransformRotation == .right ? .left : .right
        
        UIView.animate(withDuration: GConstants.Animation.Duration.AnimationView.standard) { [unowned self] in
            
            self.square.center = squreCenterPosition.asPoint
            self.square.alpha = squreAlphaValue.rawValue
            self.square.transform = squreTransformRotation == .right ? .identity : self.square.transform.rotated(by: .pi)
            
        } completion: { [unowned self] _ in
            
            self.isAnimating = false
            
        }
    }
    
}


extension BAVCombined1: UIStyler {
    
    func setStyle(_ style: UIUserInterfaceStyle = .dark, animated: Bool = false) {
        
        if animated {
            
            UIView.animate(withDuration: GConstants.Animation.Duration.standard) { [unowned self] in
                descriptionLabel.textColor = style == .light ? UIColor(white: 0, alpha: 0.6) : UIColor(white: 1, alpha: 0.6)
            }
            
        } else {
            
            descriptionLabel.textColor = style == .light ? UIColor(white: 0, alpha: 0.6) : UIColor(white: 1, alpha: 0.6)
            
        }
        
    }
    
}


extension BAVCombined1 {
    
    enum Constants {
        
        static let descriptionTextPrefix = "Position + Alpha + Rotation"
        
    }
    
}




