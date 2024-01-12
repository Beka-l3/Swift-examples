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
    
    
//    MARK: exposed func
    func startAnimation() {
        
        switch type {
            
        case .position:
            break
            
        case .alpha:
            break
            
        case .size:
            break
            
        case .rotation:
            break
            
        case .color:
            break
            
        case .combined1:
            break
            
        case .combined2:
            break
            
        case .none:
            break
            
        }
        
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
