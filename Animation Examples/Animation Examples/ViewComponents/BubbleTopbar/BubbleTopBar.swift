//
//  BubbleTopBar.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 24.01.2024.
//

import UIKit



protocol BubbleTopbarViewDelegate: AnyObject {
    func tapOnAvatar()
    func tapOnNotifications()
}


final class BubbleTopbarView: UIView {
    
    
//    MARK: exposed properties
    weak var delegate: BubbleTopbarViewDelegate?
    
    let viewComponents = BubbleTopbarViewComponents()
    
    var isLeftBubbleOnFront: Bool = true
    
    
//    MARK: private properties
    private var isAnimating: Bool = false
    
    
//    MARK: lifecycle
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayers()
    }
    
    
//    MARK: private func
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .systemOrange
        layer.cornerRadius = Constants.cornerRadius
        layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Constants.viewHeight)
        ])
        
        viewComponents.setupViews(parent: self)
        
        viewComponents.tapHandler.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeBubblesState)))
        viewComponents.avatarImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAvatarTap)))
        viewComponents.notificationBellView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleNotificationTap)))
        viewComponents.avatarImageView.isUserInteractionEnabled = true
    }
    
    private func setupLayers() {
        viewComponents.setupLayers(parent: self)
    }
    
}


extension BubbleTopbarView {
    
    @objc func changeBubblesState() {
        guard !isAnimating else { return }
        
        isAnimating = true
        isLeftBubbleOnFront.toggle()
        
        let leftBubbleAnimations = viewComponents.leftBubble.getChangeStateAnimationKeyFrames()
        let rightBubbleAnimations = viewComponents.rightBubble.getChangeStateAnimationKeyFrames()
        
        UIView.animate(withDuration: Constants.animationDuration) { [unowned self] in
            
            leftBubbleAnimations()
            rightBubbleAnimations()
            self.layoutIfNeeded()
            
        } completion: { [unowned self] _ in
            
            self.isAnimating = false
            
        }
    }
    
    @objc func handleAvatarTap() {
        delegate?.tapOnAvatar()
    }
    
    @objc func handleNotificationTap() {
        delegate?.tapOnNotifications()
    }
    
}

extension BubbleTopbarView {
    
    func setAvatar(_ image: UIImage) {
        viewComponents.avatarImageView.image = image
    }
    
    func setUsername(_ username: String) {
        viewComponents.userNameLabel.text = username
    }
    
    func setData(leftToShare: Int, yourBalance: Int, remainingDays: Int) {
        viewComponents.leftBubble.setData(leftToShare)
        viewComponents.rightBubble.setData(yourBalance)
        viewComponents.setRemainingDays(count: remainingDays)
    }
    
    func setNotificationsCount(_ count: Int) {
        viewComponents.notificationBellView.setNotificationsCount(count)
    }
    
}


extension BubbleTopbarView {
    
    enum Constants {
        
        static let viewHeight: CGFloat = 322
        static let cornerRadius: CGFloat = 20
        
        static let animationDuration: TimeInterval = 0.6
        
        static let avatarSize: CGSize = .init(width: 44, height: 44)
        
        static let bubbleSizeLarge: CGFloat = 144
        static let bubbleSizeSmall: CGFloat = 96
        
        static let bubbleBorderSize: CGFloat = 22
        
    }
    
}

