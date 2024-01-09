//
//  AnimationTableViewCells.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 09.01.2024.
//

import UIKit


final class AnimationTableViewCell: UITableViewCell {
    
    
//    MARK: static properties
    static let identifier = "AnimationTableViewCellId"
    static let animationViewHeight: CGFloat = 144
    
    
//    MARK: exposed properties
    var isDescriptionHidden: Bool = false {
        didSet {
            UIView.animate(withDuration: GConstants.Animation.Duration.standard) { [unowned self] in
                self.descriptionLabel.alpha = isDescriptionHidden ? 0 : 1
            }
        }
    }
    
    var animationVM: AnimationVM? {
        didSet {
            if let animationVM = animationVM {
                descriptionLabel.text = animationVM.description
                animationView = animationVM.view
            }
        }
    }
    
    
//    MARK: viewComponents
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.subheadline
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var animationView: AnimationView? {
        didSet {
            if let oldValue = oldValue {
                oldValue.removeFromSuperview()
            }
            
            if let animationView = animationView {
                animationView.frame = .init(
                    origin: .zero,
                    size: .init(width: GConstants.HIG.Size.screen.width, height: AnimationTableViewCell.animationViewHeight)
                )
            }
        }
    }
    
    
//    MARK: lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
//    MARK: exposed func
    func setAnimationView(_ vm: AnimationVM) {
        animationVM = vm
    }
    
    
//    MARK: private func
    private func setupView() {
        setStyle(animated: false)
        
        backgroundColor = .clear
        
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: GConstants.HIG.Padding.Four.x2),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: GConstants.HIG.Padding.Four.x2),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant:  -GConstants.HIG.Padding.Four.x2),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -GConstants.HIG.Padding.Four.x2),
        ])
    }
    
}


extension AnimationTableViewCell {
    
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

