//
//  ProfileAvatarDiscountView.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 12.02.2024.
//

import UIKit


final class ProfileAvatarDiscountView: UIView {
    
    private(set) var discount: Int = 0 { didSet { label.text = "\(discount)%" } }
    private lazy var label = _TitleLabel(type: .first(alignment: .center), fontSize: 15, textColor: Constants.fontColor)
    
    
//    MARK: lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureAutolayout()
        setDiscount()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
}


extension ProfileAvatarDiscountView {
    
    private func configure() {
        backgroundColor = Constants.bgColor
        layer.cornerRadius = Constants.viewDimensions / 2
        
        addSubview(label)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureAutolayout() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: Constants.viewDimensions),
            heightAnchor.constraint(equalToConstant: Constants.viewDimensions),
            
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: Constants.viewDimensions),
            label.heightAnchor.constraint(equalToConstant: Constants.viewDimensions),
        ])
    }
}


extension ProfileAvatarDiscountView {
    
    func setDiscount(_ newValue: Int = 0) {
        switch newValue {
            
        case Int.min...0:
            discount = 0
            
        case 1...100:
            discount = newValue
            
        default:
            discount = 100
            
        }
        
        alpha = discount == 0 ? 0 : 1
    }
}


extension ProfileAvatarDiscountView {
    
    enum Constants {
        
        static let bgColor:             UIColor     = .init(red: 239/255, green: 246/255, blue: 238/255, alpha: 1)
        static let fontColor:           UIColor     = .init(red: 82/255, green: 116/255, blue: 74/255, alpha: 1)
        
        static let viewDimensions:      CGFloat     = 44
    }
}

