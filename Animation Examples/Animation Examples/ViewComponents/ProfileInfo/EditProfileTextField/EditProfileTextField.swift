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
