//
//  ProfileStatisticsItemView.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 12.02.2024.
//


import UIKit


final class ProfileStatisticsItemView: UIView {
    
    private lazy var label = TitleLabel(type: .first(alignment: .left), fontSize: Constants.labelFontSize, textColor: .white)
    private lazy var gradientBgLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.type = .axial
        layer.startPoint = .init(x: 0, y: 0)
        layer.endPoint = .init(x: 1, y: 0)
        return layer
    }()
    
    private var widthConstraint: NSLayoutConstraint?
    
    
//    MARK: lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureAutolayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(title: String, with gradients: BgGradients = .tfOrange) {
        self.init(frame: .zero)
        label.text = title
        label.textColor = gradients.textColor
        gradientBgLayer.colors = gradients.asColors.map { $0.cgColor }
        configureWidth()
    }
}


extension ProfileStatisticsItemView {
    
    private func configure() {
        addSubview(label)
        layer.addSublayer(gradientBgLayer)
        
        label.layer.zPosition = 10
        gradientBgLayer.zPosition = 5
        
        backgroundColor = .clear
        layer.cornerRadius = Constants.viewHeight / 2.25
        clipsToBounds = true
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureAutolayout() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.paddingM),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.paddingM),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            heightAnchor.constraint(equalToConstant: Constants.viewHeight)
        ])
        
        widthConstraint = widthAnchor.constraint(equalToConstant: Constants.defaultWidth)
        widthConstraint?.isActive = true
    }
    
    private func configureWidth() {
        let widthThatFits = label.sizeThatFits(.init(width: .infinity, height: Constants.viewHeight)) .width
        
        let width = min(widthThatFits, Constants.maxWidth) + 2 * Constants.paddingM
        
        widthConstraint?.constant = width
        gradientBgLayer.frame = .init(origin: .zero, size: .init( width: width, height: Constants.viewHeight))
        
        layoutIfNeeded()
    }
}


extension ProfileStatisticsItemView {
    
    func setTitle(_ title: String, with color: UIColor = .systemOrange) {
        label.text = title
        configure()
        backgroundColor = color
    }
}


extension ProfileStatisticsItemView {
 
    enum Constants {
        
        static let padding:             CGFloat     = 12
        static let paddingM:            CGFloat     = 16
        
        static let labelFontSize:       CGFloat     = 16
        static let viewHeight:          CGFloat     = 30
        
        static let defaultWidth:        CGFloat     = 60
        
        static let maxWidth:            CGFloat     = 280
    }
}

