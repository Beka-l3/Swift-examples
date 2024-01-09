//
//  BAVAlpha.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 09.01.2024.
//

import UIKit


final class BAVAlpha: UIView {
    

//    MARK: exposed properties
    var isDescriptionHidden: Bool {
        didSet {
            UIView.animate(withDuration: GConstants.Animation.Duration.standard) { [unowned self] in
                self.descriptionLabel.alpha = isDescriptionHidden ? 0 : 1
            }
        }
    }
    
    var squreAlphaValue: SquareHero.AlphaValue = .one
    
//    MARK: private properties
    private var isAnimating: Bool = false
    
    private var descriptionText = Constants.descriptionTextPrefix + Constants.descriptionTextSuffixState2 {
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
        setDescriptionText()
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
    }
    
    private func setDescriptionText() {
        descriptionText = Constants.descriptionTextPrefix + (squreAlphaValue == .one ? Constants.descriptionTextSuffixState2 : Constants.descriptionTextSuffixState1)
    }
}


extension BAVAlpha: AnimationView {
    
    func startAnimation() {
        guard !isAnimating else { return }
        
        isAnimating = true
        squreAlphaValue = squreAlphaValue == .one ? .zero : .one
        
        UIView.animate(withDuration: GConstants.Animation.Duration.AnimationView.less) { [unowned self] in
            
            self.square.alpha = squreAlphaValue.rawValue
            
        } completion: { [unowned self] _ in
            
            self.isAnimating = false
            self.setDescriptionText()
            
        }
    }
    
}


extension BAVAlpha: UIStyler {
    
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


extension BAVAlpha {
    
    enum Constants {
        
        static let descriptionTextPrefix = "Tap on this row to set alpha of the square to"
        static let descriptionTextSuffixState2 = " 0"
        static let descriptionTextSuffixState1 = " 1"
        
    }
    
}

