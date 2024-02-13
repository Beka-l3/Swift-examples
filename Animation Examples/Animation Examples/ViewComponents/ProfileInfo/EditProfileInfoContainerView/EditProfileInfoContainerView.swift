//
//  EditProfileInfoContainerView.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 13.02.2024.
//

import UIKit


protocol EditProfileInfoContainerViewDelegate: AnyObject {
    func didTapBackButton()
    func safeToSave(with userInfoToSave: UserInfoToSave)
    func didTapVKButton()
    func didTapAvatarImage()
//    func notSafeToSave(with error: EditProfileInfoContainerView.SaveError)
}


final class EditProfileInfoContainerView: UIView {
    
    weak var delegate: EditProfileInfoContainerViewDelegate?
    
    var activeField: EditProfileTextField? {
        willSet { activeField?.checkContent() }
        didSet { activeField?.hideMessage() }
    }
    
    let uiConfig = EditProfileInfoContainerViewUIConfig()
    
    
//    MARK: lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
}


extension EditProfileInfoContainerView {
    
    private func configure() {
        uiConfig.rootView = self
        uiConfig.configureUI()
        uiConfig.configureAutolayout()
        
        uiConfig.navbar.delegate = self
        uiConfig.avatarImageView.delegate = self
        uiConfig.vkButton.addTarget(self, action: #selector(handleVKButton), for: .touchUpInside)
        uiConfig.saveButton.addTarget(self, action: #selector(handleSaveButton), for: .touchUpInside)
        for tf in uiConfig.textFields { tf.textField.delegate = self }
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing)))
    }
}


extension _EditProfileInfoContainerView {
    
    func setData(userInfo: UserInfo) {
        uiConfig.nameField.textField.text           = userInfo.name
        uiConfig.surenameField.textField.text       = userInfo.surename
        uiConfig.patrioticNameField.textField.text  = userInfo.patrioticName
        uiConfig.birthdateField.textField.text      = userInfo.birthday
        uiConfig.locationField.textField.text       = userInfo.location.city + ", " + userInfo.location.country
        uiConfig.emailField.textField.text          = userInfo.email
        uiConfig.phoneField.textField.text          = userInfo.phoneNumber
        uiConfig.avatarImageView.imageUrl           = userInfo.avatarUrl
    }
    
    func setAvatarImage(_ image: UIImage) {
        uiConfig.avatarImageView.image = image
    }
}


extension EditProfileInfoContainerView {
    
    override func endEditing(_ force: Bool) -> Bool {
        super.endEditing(force)
        activeField?.resignFirstResponder()
        activeField = nil
        return true
    }
}


extension EditProfileInfoContainerView {
    
    func isSafeForSave() throws {
        guard let _ = uiConfig.avatarImageView.image else { throw SaveError.noImage }
        guard uiConfig.nameField.isSafeToSave else { throw SaveError.noName }
        guard uiConfig.surenameField.isSafeToSave else { throw SaveError.noSurname }
        guard uiConfig.patrioticNameField.isSafeToSave else { throw SaveError.noPatrioticName }
        guard uiConfig.locationField.isSafeToSave else { throw SaveError.noLocation }
        guard uiConfig.emailField.isSafeToSave else { throw SaveError.noEmail }
        guard uiConfig.phoneField.isSafeToSave else { throw SaveError.noPhoneNumber }
    }
}


extension EditProfileInfoContainerView {
    
    enum SaveError: String, Error {
        case noImage            = "Фото профиля не бырано"
        case noName             = "Поле имени не заполнено"
        case noSurname          = "Поле фамилий не заполнено"
        case noPatrioticName    = "Поле отчество не заполнено"
        case noBirthdate        = "Поле даты рождения не заполнено"
        case noLocation         = "Поле место нахождений не заполнено"
        case noEmail            = "Поле почты не заполнено"
        case noPhoneNumber      = "Поле мобильного номера не заполнено"
    }
}
