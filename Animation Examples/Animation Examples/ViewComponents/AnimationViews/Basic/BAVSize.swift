//
//  BVASize.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 09.01.2024.
//

import UIKit


final class BAVSize: UIView {
    

//    MARK: exposed properties
    var isDescriptionHidden: Bool {
        didSet {
            UIView.animate(withDuration: GConstants.Animation.Duration.standard) { [unowned self] in
                self.descriptionLabel.alpha = isDescriptionHidden ? 0 : 1
            }
        }
    }
    
    var squreTransformSize: SquareHero.TransformSize = .small
    
    
//    MARK: private properties
    private var isAnimating: Bool = false
    
//    private var descriptionText = Constants.descriptionTextPrefix + Constants.descriptionTextSuffixState2 {
    private var descriptionText = Constants.descriptionTextPrefix {
        didSet {
            descriptionLabel.text = descriptionText
        }
    }
    
//    MARK: viewComponents
    lazy var square: UIView = SquareHero.getSquare(centerPosition: .rightCenter)
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.subheadline
        label.numberOfLines = .zero
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
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: GConstants.HIG.Padding.Eight.x2),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(GConstants.HIG.Padding.Eight.x2 + SquareHero.squareDimension + GConstants.HIG.Padding.Four.x2)),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -GConstants.HIG.Padding.Four.x2),
        ])
        
        descriptionLabel.text = descriptionText
    }
    
}


extension BAVSize: AnimationView {
    
    func startAnimation() {
        guard !isAnimating else { return }
        
        isAnimating = true
        squreTransformSize = squreTransformSize == .small ? .large : .small
        
        UIView.animate(withDuration: GConstants.Animation.Duration.AnimationView.fast) { [unowned self] in
            
            switch squreTransformSize {
                
            case .small:
                self.square.transform = .identity
                
            case .large:
                self.square.transform = self.square.transform.scaledBy(x: 1.25, y: 1.25)
                
            }
            
        } completion: { [unowned self] _ in
            
            self.isAnimating = false
            
        }
    }
    
}


extension BAVSize: UIStyler {
    
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


extension BAVSize {
    
    enum Constants {
        
        static let descriptionTextPrefix = "Size"
        
    }
    
}

