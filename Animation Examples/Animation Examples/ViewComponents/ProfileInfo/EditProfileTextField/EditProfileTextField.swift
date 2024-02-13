//
//  EditProfileTextField.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 13.02.2024.
//

import UIKit


final class EditProfileTextField: UIView {
    enum FieldType: Equatable {
        case text, email, phone, date
    }
    
    private(set) var isMandatory: Bool = true
    private(set) var type: FieldType
    private let uiConfig: EditProfileTextFieldUIConfig
    
    
//    MARK: lifecycle
    required init?(coder: NSCoder) {
        self.type = .text
        self.isMandatory = false
        self.uiConfig = .init(type: self.type)
        super.init(coder: coder)
    }
    
    init(type: FieldType, caption: String, placeholder: String, isMandatory: Bool = true) {
        self.type = type
        self.isMandatory = isMandatory
        self.uiConfig = .init(type: type)
        super.init(frame: .zero)
        
        uiConfig.textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: Constants.textFieldBorderColor,
                NSAttributedString.Key.font: Constants.textFieldPlaceholderFont
            ]
        )
        uiConfig.messageLabel.text = Constants.messageLabelText
        uiConfig.mandatoryImageView.alpha = isMandatory ? 1 : 0
        
        uiConfig.captionLabel.text = caption
        if type == .phone { uiConfig.textField.keyboardType = .numberPad }
        
        configure()
    }
    
}


extension EditProfileTextField {
    private func configure() {
        uiConfig.rootView = self
        uiConfig.configureUI()
        uiConfig.configureAutolayout()
    }
}


extension EditProfileTextField {
    func checkContent() {
        if isMandatory, (uiConfig.textField.text ?? "").isEmpty {
            uiConfig.showMessage(type: .empty)
        } else {
            switch type {
                
            case .email:
//                #warning("Написать логику для проверки валидности почты")
//                if isValidEmail(textField.text ?? "") { uiConfig.showMessage(type: .invalidEmail) }
                break
                
            case .phone:
//                #warning("Написать логику для проверки валидности мобильного номера")
//                if isValidPhone(textField.text ?? "") { uiConfig.showMessage(type: .invalidPhone) }
                break
                
            default:
                break
                
            }
        }
    }
}


extension EditProfileTextField {
    
    @discardableResult
    override func resignFirstResponder() -> Bool {
        let res = super.resignFirstResponder()
        uiConfig.textField.resignFirstResponder()
        checkContent()
        return res
    }
    
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        let res = super.becomeFirstResponder()
        uiConfig.textField.becomeFirstResponder()
        uiConfig.hideMessage()
        return res
    }
}


extension EditProfileTextField {
    
    func getData() -> String {
        uiConfig.textField.text ?? ""
    }
    
    func hideMessage() {
        uiConfig.hideMessage()
    }
    
    var isSafeToSave: Bool {
        uiConfig.messageLabel.alpha == 0
    }
    
    var textFieldReturnKeyType: UIReturnKeyType {
        get { uiConfig.textFieldReturnKeyType }
        set { uiConfig.textFieldReturnKeyType = newValue}
    }
    
    var textField: UITextField {
        get { uiConfig.textField }
    }
}


extension EditProfileTextField {
    
    enum Constants {
        
        static let textFieldBorderColor:            UIColor     = .gray.withAlphaComponent(0.38)
        static let textFieldPlaceholderFont:        UIFont      = .systemFont(ofSize: 13)
        
        static let messageLabelText:                String      = "Поле не заполнено"
    }
    
    enum MessageType: String {
        case empty                      = "Поле не заполнено"
        case invalidEmail               = "Не правильная почта"
        case invalidPhoneNumber         = "Не правильный мобильный номер"
    }
}
