//
//  ProfileInfoContainerView.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 12.02.2024.
//

import UIKit


protocol ProfileInfoContainerViewDelegate: AnyObject {
    func didTapEditButton()
}


final class ProfileInfoContainerView: UIView {
    
    weak var delegate: ProfileInfoContainerViewDelegate?
    
    private lazy var avatarImageView = ProfileAvatarView(with: Constants.avatarImageDimension, borderWidth: Constants.avatarImageBorderWidth)
    private lazy var discountView = ProfileAvatarDiscountView()
    
    private lazy var editButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .white.withAlphaComponent(0.1)
        button.setImage(GConstants.Images.pencil, for: .normal)
        button.layer.cornerRadius = Constants.editButtonDimension / 2
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleEditButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var detailsContainerView   = ProfileInfoDetailsContainerView(topPadding: Constants.avatarImageDimension / 2)
    
    
//    MARK: lifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureAutolayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
}


extension ProfileInfoContainerView {
    
    private func configure() {
        backgroundColor = .clear
        
        addSubview(detailsContainerView)
        addSubview(editButton)
        addSubview(avatarImageView)
        addSubview(discountView)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureAutolayout() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor),
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: Constants.avatarImageDimension),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.avatarImageDimension),
            
            discountView.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Constants.paddingS),
            discountView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -Constants.paddingS / 2),
            
            editButton.topAnchor.constraint(equalTo: topAnchor, constant: Constants.padding),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding),
            editButton.heightAnchor.constraint(equalToConstant: Constants.editButtonDimension),
            editButton.widthAnchor.constraint(equalToConstant: Constants.editButtonDimension),
            
            detailsContainerView.topAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: Constants.paddingS),
            detailsContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailsContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            bottomAnchor.constraint(equalTo: detailsContainerView.bottomAnchor),
        ])
    }
}


extension ProfileInfoContainerView {
    func setNameAndLocation(name: String, location: String) {
        detailsContainerView.setNameAndLocation(name: name, location: location)
    }
    
    func setDiscount(_ newValue: Int) {
        discountView.setDiscount(newValue)
    }
    
    func setStatisticsItems(_ items: [ProfileStatisticsView.StatisticsItem]) {
        detailsContainerView.setStatisticsItems(items)
    }
    
    func setInfoDetails(type: ProfileInfoDetailsView.InfoType, texts: ProfileInfoDetailsView.InfoType.CaptionTexts) {
        detailsContainerView.setInfoDetails(type: type, texts: texts)
    }
    
    func setAvatar(_ image: UIImage) {
        avatarImageView.image = image
    }
    
    func setAvatar(with url: String) {
        avatarImageView.imageUrl = url
    }
}


extension ProfileInfoContainerView {
    @objc func handleEditButton() {
        delegate?.didTapEditButton()
    }
}


extension ProfileInfoContainerView {
 
    enum Constants {
        
        static let paddingS:                    CGFloat     = 8
        static let padding:                     CGFloat     = 18
        static let editButtonDimension:         CGFloat     = 22
        
        static let discountPadding:             CGFloat     = 8
        
        static let avatarImageDimension:        CGFloat     = 128
        static let avatarImageBorderWidth:      CGFloat     = 4
    }
}
