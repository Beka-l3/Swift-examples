//
//  EditProfileButton.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 13.02.2024.
//

import UIKit


final class EditProfileButton: UIButton {
    
    enum ButtonType {
        case vk, save
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(editProfileButtonType type: ButtonType) {
        self.init(frame: .zero)
        
        switch type {
            
        case .save:
            configuration?.baseBackgroundColor = .systemOrange
            setTitle(Constants.saveTitle, for: .normal)
            configuration?.buttonSize = .large
            
        case .vk:
            configuration?.baseBackgroundColor = .systemBlue
            setTitle(Constants.vkTitle, for: .normal)
            configuration?.buttonSize = .medium
            configuration?.image = Constants.vkIconReplacement
            
        }
        
    }
}


extension EditProfileButton {
    
    private func configure() {
        var config = UIButton.Configuration.filled()
        config.buttonSize = .medium
        config.cornerStyle = .large
        
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.preferredFont(forTextStyle: .caption1)
            return outgoing
        }
        
        config.imagePadding = Constants.vkIconPadding
        config.imagePlacement = .leading
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .medium)
        config.baseForegroundColor = .white
        self.configuration = config
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}


extension EditProfileButton {
    
    enum Constants {
        
        static let vkTitle:                 String      = "СВЯЗАТЬ С VK ID"
        static let saveTitle:               String      = "Сохранить"
        
        static let vkIconReplacement:       UIImage?    = GConstants.Images.kipsign
        static let vkIconDimension:         CGFloat     = 16
        static let vkIconPadding:           CGFloat     = 5
    }
}

