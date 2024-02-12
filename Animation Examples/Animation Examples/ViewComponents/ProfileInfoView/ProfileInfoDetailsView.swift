//
//  ProfileInfoDetailsView.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 12.02.2024.
//

import UIKit


final class ProfileInfoDetailsView: UIView {
    
    private lazy var firstLabelCaption  = TitleLabel(type: .first(alignment: .left), fontSize: Constants.captionFontSize, textColor: .gray)
    private lazy var secondLabelCaption = TitleLabel(type: .first(alignment: .left), fontSize: Constants.captionFontSize, textColor: .gray)
    private lazy var thirdLabelCaption  = TitleLabel(type: .first(alignment: .left), fontSize: Constants.captionFontSize, textColor: .gray)
    
    private lazy var firstLabel         = TitleLabel(type: .first(alignment: .left), fontSize: Constants.labelFontSize)
    private lazy var secondLabel        = TitleLabel(type: .first(alignment: .left), fontSize: Constants.labelFontSize)
    private lazy var thirdLabel         = TitleLabel(type: .first(alignment: .left), fontSize: Constants.labelFontSize)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(type: InfoType) {
        self.init(frame: .zero)
        
        let captionTexts = type.asCaptionTexts
        firstLabelCaption.text = captionTexts.first
        secondLabelCaption.text = captionTexts.second
        thirdLabelCaption.text = captionTexts.third
    }
}


extension ProfileInfoDetailsView {
    
    private func configure() {
        backgroundColor = .white
        layer.cornerRadius = Constants.cornerRadius
        
        addSubview(firstLabelCaption)
        addSubview(firstLabel)
        
        addSubview(secondLabelCaption)
        addSubview(secondLabel)
        
        addSubview(thirdLabelCaption)
        addSubview(thirdLabel)
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = Constants.shadowOffset
        layer.shadowOpacity = Constants.shadowOpacity
        layer.shadowRadius = Constants.shadowRadius
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureAutoLayout() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Constants.viewHeight),
            
            firstLabelCaption.topAnchor.constraint(equalTo: topAnchor, constant: Constants.paddingS),
            firstLabelCaption.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.paddingS),
            firstLabelCaption.heightAnchor.constraint(equalToConstant: Constants.captionHeight),
            firstLabelCaption.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.paddingS),
            
            firstLabel.topAnchor.constraint(equalTo: firstLabelCaption.bottomAnchor, constant: Constants.paddingXS),
            firstLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.paddingS),
            firstLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight),
            firstLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.paddingS),
            
            secondLabelCaption.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: Constants.padding),
            secondLabelCaption.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.paddingS),
            secondLabelCaption.heightAnchor.constraint(equalToConstant: Constants.captionHeight),
            secondLabelCaption.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.paddingS),
            
            secondLabel.topAnchor.constraint(equalTo: secondLabelCaption.bottomAnchor, constant: Constants.paddingXS),
            secondLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.paddingS),
            secondLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight),
            secondLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.paddingS),
            
            thirdLabelCaption.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: Constants.padding),
            thirdLabelCaption.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.paddingS),
            thirdLabelCaption.heightAnchor.constraint(equalToConstant: Constants.captionHeight),
            thirdLabelCaption.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.paddingS),
            
            thirdLabel.topAnchor.constraint(equalTo: thirdLabelCaption.bottomAnchor, constant: Constants.paddingXS),
            thirdLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.paddingS),
            thirdLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight),
            thirdLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.paddingS),
        ])
    }
}


extension ProfileInfoDetailsView {
    
    enum Constants {
        
        static let shadowOpacity:       Float       = 0.1
        
        static let paddingXS:           CGFloat     = 6
        static let paddingS:            CGFloat     = 12
        static let padding:             CGFloat     = 16
        
        static let cornerRadius:        CGFloat     = 12
        
        static let captionFontSize:     CGFloat     = 12
        static let labelFontSize:       CGFloat     = 14
        
        static let captionHeight:       CGFloat     = 16
        static let labelHeight:         CGFloat     = 18
        
        static let shadowRadius:        CGFloat     = 8
        static let shadowOffset:        CGSize      = .init(width: 0, height: 8)
        
        static let viewHeight:          CGFloat     = 3 * (captionHeight + labelHeight + paddingXS) + 2 * (paddingS + padding)
    }
    
    enum InfoType {
        case name
        case contants
        case company
        
        typealias CaptionTexts = (first: String, second: String, third: String)
        var asCaptionTexts: CaptionTexts {
            
            switch self {
                
            case .name:
                return ("Имя", "Фамилия", "Отчество")
                
            case .contants:
                return ("Почта", "Мобильный номер", "День Рождения")
                
            case .company:
                return ("Компания", "Подразделение", "Обо мне")
                
            }
        }
    }
}


extension ProfileInfoDetailsView {
    
    func setTitlesText(texts: InfoType.CaptionTexts) {
        firstLabel.text = texts.first
        secondLabel.text = texts.second
        thirdLabel.text = texts.third
    }
}

