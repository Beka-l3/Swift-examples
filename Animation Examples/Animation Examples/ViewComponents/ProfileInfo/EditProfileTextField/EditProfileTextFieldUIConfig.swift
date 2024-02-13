//
//  EditProfileTextFieldUIConfig.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 13.02.2024.
//

import UIKit


final class EditProfileTextFieldUIConfig {
    
    weak var rootView: UIView?
    
    lazy var captionLabel: TitleLabel = .init(type: .secondary, fontSize: Constants.captionLabelFontSize, textColor: .gray)
    lazy var mandatoryImageView: UIImageView = {
        let view = UIImageView()
        view.image = Constants.mandatoryIcon
        view.tintColor = .systemRed
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var textFieldReturnKeyType: UIReturnKeyType = .next { didSet { textField.returnKeyType = textFieldReturnKeyType } }
    lazy var textField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.font = .systemFont(ofSize: Constants.textFieldFontSize)
        field.textColor = .black
        field.tintColor = .systemOrange
        field.setLeftPaddingPoints(Constants.padding)
        field.layer.borderColor = Constants.textFieldBorderColor.cgColor
        field.layer.borderWidth = Constants.textFieldBorderWidth
        field.layer.cornerRadius = Constants.textFieldCornerRadius
        
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var messageLabel: TitleLabel = .init(type: .secondary, fontSize: Constants.captionLabelFontSize, textColor: .systemRed)
    var heightConstraint: NSLayoutConstraint?
    
    
    
//    MARK: lifecycle
    private(set) var type: EditProfileTextField.FieldType
    
    init(type: EditProfileTextField.FieldType) {
        self.type = type
    }
    
}


extension EditProfileTextFieldUIConfig {
    
    func adjustHeight() {
        heightConstraint?.constant = Constants.viewHeightCompact + (type == .date ? Constants.hideButtonHeight : 0) + (messageLabel.alpha * Constants.messageLabelHeight)
        rootView?.layoutIfNeeded()
    }
    
    func showMessage(type: EditProfileTextField.MessageType) {
        messageLabel.text = type.rawValue
        messageLabel.alpha = 1
        adjustHeight()
    }
    
    func hideMessage() {
        messageLabel.text = ""
        messageLabel.alpha = 0
        adjustHeight()
    }
}


extension EditProfileTextFieldUIConfig {
    
    func configureUI() {
        guard let rootView = rootView else { return }
        
        textField.returnKeyType = .next
        
        rootView.backgroundColor = .clear
        messageLabel.alpha = 0
        
        rootView.addSubview(captionLabel)
        rootView.addSubview(mandatoryImageView)
        rootView.addSubview(textField)
        rootView.addSubview(messageLabel)
        
        rootView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureAutolayout() {
        guard let rootView = rootView else { return }
        
        NSLayoutConstraint.activate([
            captionLabel.topAnchor.constraint(equalTo: rootView.topAnchor),
            captionLabel.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            captionLabel.heightAnchor.constraint(equalToConstant: Constants.captionLabelHeight),
            
            mandatoryImageView.topAnchor.constraint(equalTo: captionLabel.topAnchor),
            mandatoryImageView.leadingAnchor.constraint(equalTo: captionLabel.trailingAnchor),
            mandatoryImageView.widthAnchor.constraint(equalToConstant: Constants.mandatoryIconDimension),
            mandatoryImageView.heightAnchor.constraint(equalToConstant: Constants.mandatoryIconDimension),
            
            textField.topAnchor.constraint(equalTo: captionLabel.bottomAnchor, constant: Constants.paddingS),
            textField.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: rootView.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            
            messageLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Constants.paddingS),
            messageLabel.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            messageLabel.heightAnchor.constraint(equalToConstant: Constants.messageLabelHeight),
        ])
        
        let height = Constants.viewHeightCompact + (type == .date ? Constants.hideButtonHeight : 0) + (messageLabel.alpha * Constants.messageLabelHeight)
        heightConstraint = rootView.heightAnchor.constraint(equalToConstant: height)
        heightConstraint?.isActive = true
    }
}


extension EditProfileTextFieldUIConfig {
    enum Constants {
        
        static let paddingXS:                       CGFloat     = 4
        static let paddingS:                        CGFloat     = 8
        static let padding:                         CGFloat     = 16
        
        static let viewHeightCompact:               CGFloat     = captionLabelHeight + textFieldHeight + Constants.paddingS
        static let viewHeightExtended:              CGFloat     = viewHeightCompact + messageLabelHeight
        
        static let hideButtonHeight:                CGFloat     = 30
        
        static let captionLabelFontSize:            CGFloat     = 14
        static let captionLabelHeight:              CGFloat     = 16
        
        static let textFieldFontSize:               CGFloat     = 17
        static let textFieldHeight:                 CGFloat     = 44
        static let textFieldBorderWidth:            CGFloat     = 0.5
        static let textFieldCornerRadius:           CGFloat     = 8
        static let textFieldBorderColor:            UIColor     = .gray.withAlphaComponent(0.38)
        static let textFieldPlaceholderFont:        UIFont      = .systemFont(ofSize: 13)
        
        static let messageLabelHeight:              CGFloat     = 14
        static let messageLabelText:                String      = "Поле не заполнено"
        
        static let mandatoryIcon:                   UIImage?    = UIImage(systemName: "staroflife.fill")
        static let mandatoryIconDimension:          CGFloat     = 6
    }
}
