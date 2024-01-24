//
//  BubbleTopbarViewComponents.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 24.01.2024.
//

import UIKit



final class BubbleTopbarViewComponents {
    
    lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = Constants.avatarSizeDimension / 2
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var welcomingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Constants.usernameDefaultFont
        label.text = Constants.welcomingText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Constants.usernameDefaultFont
        label.text = Constants.userNameLabelDefaultText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var welcomeUsernameStack: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .clear
        view.alignment = .leading
        view.axis = .vertical
        view.addArrangedSubview(welcomingLabel)
        view.addArrangedSubview(userNameLabel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tapHandler: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var leftBubble = BubbleView(state: .large, secondaryText: Constants.leftBubbleText)
    lazy var rightBubble = BubbleView(state: .small, secondaryText: Constants.rightBubbleText)
    
    lazy var remainingDaysLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = Constants.remainingDaysFont
        label.text = Constants.remainingDayText + "\(Constants.remainingDaysDefaultNumber)" + Constants.daysText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bgGradient: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.type = .axial
        layer.colors = [Constants.gradientColorFrirst.cgColor, Constants.gradientColorSecond.cgColor]
        layer.startPoint = Constants.leftPoint
        layer.startPoint = Constants.rightPoint
        return layer
    }()
    
    lazy var bgBubbles: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = Constants.bgBubblesImage
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var notificationBellView: NotificationBellView = .init()
    
    
//    MARK: exposed func
    func setupViews(parent: UIView) {
        parent.clipsToBounds = true
        
        parent.layer.addSublayer(bgGradient)
        
        parent.addSubview(bgBubbles)
        parent.addSubview(avatarImageView)
        parent.addSubview(notificationBellView)
        parent.addSubview(welcomeUsernameStack)
        parent.addSubview(leftBubble)
        parent.addSubview(rightBubble)
        parent.addSubview(remainingDaysLabel)
        parent.addSubview(tapHandler)
        
        setupConstraints(parent: parent)
    }
    
    func setupLayers(parent: UIView) {
        bgGradient.frame = parent.bounds
    }
    
}


extension BubbleTopbarViewComponents {
    func setRemainingDays(count: Int) {
        remainingDaysLabel.text = Constants.remainingDayText + "\(count)" + Constants.daysText
    }
}


extension BubbleTopbarViewComponents {
    
    enum Constants {
        
        static let gradientColorFrirst: UIColor = .init(red: 241/255, green: 89/255, blue: 41/255, alpha: 1)
        static let gradientColorSecond: UIColor = .init(red: 245/255, green: 174/255, blue: 76/255, alpha: 1)
        
        static let leftPoint: CGPoint = .init(x: 0, y: 0.5)
        static let rightPoint: CGPoint = .init(x: 1, y: 0.5)
        
        static let avatarSizeDimension: CGFloat = 48
        
        static let bubbleSizeL: CGFloat = BubbleView.Constants.dimensionL + BubbleView.Constants.borderWidth
        static let bubbleSizeS: CGFloat = BubbleView.Constants.dimensionS + BubbleView.Constants.borderWidth
        
        static let leftBubbleText = "Осталось раздать"
        static let rightBubbleText = "Ваш баланс"
        
        static let welcomingText = "Привет,"
        static let userNameLabelDefaultText = "Saitama"
        
        static let remainingDayText = "До конца периода "
        static let remainingDaysDefaultNumber: Int = 99
        static let daysText = " дней"
        
        static let remainingDaysFont: UIFont = .systemFont(ofSize: 10)
        static let usernameDefaultFont: UIFont =  .systemFont(ofSize: 16, weight: .medium)
        
        static let bubbleXPositionPadding: CGFloat = 18 + bubbleSizeL / 2
        static let leftBubbleBottomPadding: CGFloat = 35
        static let rightBubbleTopPadding: CGFloat = 35
        
        static let paddingM: CGFloat = 16
        static let paddingL: CGFloat = 30
        
        static let bgBubblesDimension: CGFloat = 220
        
        static let bgBubblesImage: UIImage? = UIImage(named: "Background Bubbles")
    }
    
}


extension BubbleTopbarViewComponents {
    
    func setupConstraints(parent: UIView) {
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.avatarSizeDimension),
            avatarImageView.widthAnchor.constraint(equalToConstant: Constants.avatarSizeDimension),
            avatarImageView.topAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: Constants.paddingM),
            
            bgBubbles.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            bgBubbles.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
            bgBubbles.widthAnchor.constraint(equalToConstant: Constants.bgBubblesDimension),
            bgBubbles.heightAnchor.constraint(equalToConstant: Constants.bgBubblesDimension),
            
            welcomeUsernameStack.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            welcomeUsernameStack.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Constants.paddingM),
            
            notificationBellView.centerYAnchor.constraint(equalTo: welcomeUsernameStack.centerYAnchor),
            notificationBellView.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -Constants.paddingM),
            
            leftBubble.centerXAnchor.constraint(equalTo: parent.leadingAnchor, constant: Constants.bubbleXPositionPadding),
            leftBubble.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -Constants.leftBubbleBottomPadding),
            
            rightBubble.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Constants.paddingM),
            rightBubble.centerXAnchor.constraint(equalTo: parent.trailingAnchor, constant: -Constants.bubbleXPositionPadding),
            
            tapHandler.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Constants.paddingM),
            tapHandler.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            tapHandler.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
            tapHandler.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
            
            remainingDaysLabel.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -Constants.paddingL),
            remainingDaysLabel.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -Constants.paddingL),
        ])
    }
    
}
