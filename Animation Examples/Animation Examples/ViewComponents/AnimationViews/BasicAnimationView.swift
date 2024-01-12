//
//  BasicAnimationView.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 12.01.2024.
//

import UIKit


final class BasicAnimationView: UIView, AnimationView {
    
    enum BAVType: String {
        case position = "Position"
        case alpha = "Alpha"
        case size = "Size"
        case rotation = "Rotation"
        case color = "Color"
        case combined1 = "Position + Alpha + Rotation"
        case combined2 = "Position + Color + Size"
        
        case none = ""
    }
    
//    MARK: exposed properties
    let type: BAVType
    let descriptionText: String
    
    var isDescriptionHidden: Bool {
        didSet {
            UIView.animate(withDuration: GConstants.Animation.Duration.standard) { [unowned self] in
                self.descriptionLabel.alpha = isDescriptionHidden ? 0 : 1
            }
        }
    }

    
//    MARK: private properties
    private var isAnimating: Bool = false
    private lazy var square: UIView = SquareHero.getSquare()
    
    private var squreCenterPosition: SquareHero.CenterPositions = .leftCenter
    private var squreAlphaValue: SquareHero.AlphaValue = .one
    private var squreTransformSize: SquareHero.TransformSize = .small
    private var squreTransformRotation: SquareHero.TransformRotation = .left
    private var squareColor: SquareHero.Color = .purple
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.subheadlineBlack
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
//    MARK: lifecycle
    init(type: BAVType, isDescriptionHidden: Bool = false) {
        self.type = type
        self.descriptionText = type.rawValue
        self.isDescriptionHidden = isDescriptionHidden
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        self.type = .none
        self.descriptionText = type.rawValue
        self.isDescriptionHidden = true
        super.init(coder: coder)
    }
    
    
//    MARK: private func
    func setupView() {
        setupFrame()
        
        addSubview(descriptionLabel)
        addSubview(square)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: GConstants.HIG.Padding.Four.x2),
            
            descriptionLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: GConstants.HIG.Padding.Eight.x4 + SquareHero.squareDimension
            ),
            
            descriptionLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -(GConstants.HIG.Padding.Eight.x4 + SquareHero.squareDimension)
            ),
            
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -GConstants.HIG.Padding.Four.x2),
        ])
        
        descriptionLabel.text = descriptionText
    }
}


extension BasicAnimationView: UIStyler {
    
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


extension BasicAnimationView {
    
    func startAnimation() {
        guard !isAnimating else { return }
        
        isAnimating = true
        
        let animation: () -> Void
        var duration = GConstants.Animation.Duration.AnimationView.fast
        
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
                self.square.transform = self.squreTransformSize == .small ? .identity : CGAffineTransform(scaleX: 1.25, y: 1.25)
            }
            
        case .rotation:
            squreTransformRotation = squreTransformRotation == .left ? .right : .left
            animation = { [unowned self] in
                self.square.transform = self.squreTransformRotation == .left ? CGAffineTransform(rotationAngle: 0) : CGAffineTransform(rotationAngle: 3.14)
            }
            
        case .color:
            squareColor = squareColor == .purple ? .yellow : .purple
            animation = { [unowned self] in
                self.square.backgroundColor = self.squareColor.asUIColor
            }
            
        case .combined1:
            squreCenterPosition = squreCenterPosition == .leftCenter ? .rightCenter : .leftCenter
            squreAlphaValue = squreAlphaValue == .one ? .zero : .one
            squreTransformRotation = squreTransformRotation == .left ? .right : .left
            duration = GConstants.Animation.Duration.AnimationView.standard
            animation = { [unowned self] in
                self.square.center = self.squreCenterPosition.asPoint
                self.square.alpha = self.squreAlphaValue.rawValue
                self.square.transform = self.squreTransformRotation == .left ? CGAffineTransform(rotationAngle: 0) : CGAffineTransform(rotationAngle: 3.14)
            }
            
        case .combined2:
            squreCenterPosition = squreCenterPosition == .leftCenter ? .rightCenter : .leftCenter
            squareColor = squareColor == .purple ? .yellow : .purple
            squreTransformSize = squreTransformSize == .small ? .large : .small
            duration = GConstants.Animation.Duration.AnimationView.standard
            animation = { [unowned self] in
                self.square.center = self.squreCenterPosition.asPoint
                self.square.backgroundColor = self.squareColor.asUIColor
                self.square.transform = self.squreTransformSize == .small ? .identity : self.square.transform.scaledBy(x: 1.25, y: 1.25)
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
