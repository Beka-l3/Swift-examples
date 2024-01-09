//
//  BAVAlpha.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 09.01.2024.
//

import UIKit


final class BAVAlpha: UIView {
    
    let descriptionText = ""
    
    var isDescriptionHidden: Bool {
        didSet {
            UIView.animate(withDuration: GConstants.Animation.Duration.standard) { [unowned self] in
                self.descriptionLabel.alpha = isDescriptionHidden ? 0 : 1
            }
        }
    }
    
    
//    MARK: viewComponents
    lazy var square: UIView = SquareHero.getSquare()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.subheadline
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
//    MARK: lifecycle
    init(isDescriptionHidden: Bool = true) {
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
        
        addSubview(square)
    }
    
}


extension BAVAlpha: AnimationView {
    
    func startAnimation() {
        
    }
    
}


extension BAVAlpha {
    
    func setStyle(_ style: UIUserInterfaceStyle = .dark, animated: Bool = true) {
        
        if animated {
            
            UIView.animate(withDuration: GConstants.Animation.Duration.standard) { [unowned self] in
                descriptionLabel.textColor = style == .light ? UIColor(white: 0, alpha: 0.6) : UIColor(white: 1, alpha: 0.6)
            }
            
        } else {
            
            descriptionLabel.textColor = style == .light ? UIColor(white: 0, alpha: 0.38) : UIColor(white: 1, alpha: 0.38)
            
        }
        
    }
    
}

