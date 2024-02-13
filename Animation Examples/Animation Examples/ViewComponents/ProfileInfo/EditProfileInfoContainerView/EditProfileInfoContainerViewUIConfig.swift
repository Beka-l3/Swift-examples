//
//  EditProfileInfoContainerViewUIConfig.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 13.02.2024.
//

import UIKit


final class EditProfileInfoContainerViewUIConfig {
    
    weak var rootView: UIView?
    
    lazy var navbar = EditProfileNavbarView(title: Constants.title)
    lazy var avatarImageView = ProfileAvatarView(with: Constants.avatarImageDimension, isEditable: true)
    lazy var vkButton = EditProfileButton(editProfileButtonType: .vk)
    
    lazy var nameField = EditProfileTextField(type: .text, caption: Constants.nameFieldText.caption, placeholder: Constants.nameFieldText.placeholder, isMandatory: true)
    lazy var surenameField = EditProfileTextField(type: .text, caption: Constants.surenameFieldText.caption, placeholder: Constants.surenameFieldText.placeholder, isMandatory: true)
    lazy var patrioticNameField = EditProfileTextField(type: .text, caption: Constants.patrioticNameFieldText.caption, placeholder: Constants.patrioticNameFieldText.placeholder, isMandatory: true)
    lazy var birthdateField = EditProfileTextField(type: .date, caption: Constants.birthdateFieldText.caption, placeholder: Constants.birthdateFieldText.placeholder, isMandatory: true)
    lazy var locationField = EditProfileTextField(type: .text, caption: Constants.locationFieldText.caption, placeholder: Constants.locationFieldText.placeholder, isMandatory: false)
    lazy var emailField = EditProfileTextField(type: .email, caption: Constants.emailFieldText.caption, placeholder: Constants.emailFieldText.placeholder, isMandatory: false)
    lazy var phoneField = EditProfileTextField(type: .phone, caption: Constants.phoneNumberFieldText.caption, placeholder: Constants.phoneNumberFieldText.placeholder, isMandatory: false)
    lazy var textFields: [EditProfileTextField] = [nameField, surenameField, patrioticNameField, birthdateField, locationField, emailField, phoneField]
    
    lazy var saveButton = EditProfileButton(editProfileButtonType: .save)
    
    var bottomConstraint: NSLayoutConstraint?
}


extension EditProfileInfoContainerViewUIConfig {
    
    func configureUI() {
        guard let rootView = rootView else { return }
        
        phoneField.textFieldReturnKeyType = .done
        
        rootView.clipsToBounds = true
        rootView.backgroundColor = .white
        
        rootView.layer.cornerRadius = Constants.cornerRadius
        rootView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        rootView.addSubview(navbar)
        rootView.addSubview(avatarImageView)
        rootView.addSubview(vkButton)
        rootView.addSubview(saveButton)
        
        for tf in textFields { rootView.addSubview(tf) }
        
        rootView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureAutolayout() {
        guard let rootView = rootView else { return }
        
        NSLayoutConstraint.activate([
            navbar.topAnchor.constraint(equalTo: rootView.topAnchor),
            navbar.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            navbar.trailingAnchor.constraint(equalTo: rootView.trailingAnchor),
            
            avatarImageView.topAnchor.constraint(equalTo: navbar.bottomAnchor, constant: Constants.paddingS),
            avatarImageView.centerXAnchor.constraint(equalTo: rootView.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: Constants.avatarImageDimension),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.avatarImageDimension),
        ])
        
        let subViews = [avatarImageView, vkButton] + textFields + [saveButton]
        
        for i in 1..<subViews.count {
            NSLayoutConstraint.activate([
                subViews[i].topAnchor.constraint(equalTo: subViews[i-1].bottomAnchor, constant: Constants.paddingM),
                subViews[i].leadingAnchor.constraint(equalTo: rootView.leadingAnchor, constant: Constants.paddingM),
                subViews[i].trailingAnchor.constraint(equalTo: rootView.trailingAnchor, constant: -Constants.paddingM),
            ])
        }
        
        bottomConstraint = rootView.bottomAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: Constants.paddingM)
        bottomConstraint?.isActive = true
    }
}


extension EditProfileInfoContainerViewUIConfig {

    enum Constants {
        typealias FieldText = (caption: String, placeholder: String)
        
        static let paddingS:                    CGFloat     = 8
        static let padding:                     CGFloat     = 16
        static let paddingM:                    CGFloat     = 20
        static let paddingL:                    CGFloat     = 34
        static let cornerRadius:                CGFloat     = 24
        static let avatarImageDimension:        CGFloat     = 112
        static let vkButtonHeight:              CGFloat     = 50
        static let keyboardHeight:              CGFloat     = 300
            
        static let title:                       String      = "Редактирование профиля"
        static let nameFieldText:               FieldText   = ("Имя", "Введите имя")
        static let surenameFieldText:           FieldText   = ("Фамилия", "Введите фамилию")
        static let patrioticNameFieldText:      FieldText   = ("Отчество", "Введите отчество")
        static let birthdateFieldText:          FieldText   = ("День рождения", "Введите дату рождения")
        static let locationFieldText:           FieldText   = ("Локация", "Введите город")
        static let emailFieldText:              FieldText   = ("Почта", "Введите почту")
        static let phoneNumberFieldText:        FieldText   = ("Мобильный номер", "Введите номер")
    }
}

