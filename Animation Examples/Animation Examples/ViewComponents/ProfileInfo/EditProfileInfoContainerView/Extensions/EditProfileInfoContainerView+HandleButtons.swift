//
//  EditProfileInfoContainerView+HandleButtons.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 13.02.2024.
//

import UIKit


extension EditProfileInfoContainerView {
    
    @objc func handleSaveButton() {
        
        do {
            try isSafeForSave()
            
            let userInfoToSave = UserInfoToSave(
                name: uiConfig.nameField.getData(),
                suername: uiConfig.surenameField.getData(),
                patrioticName: uiConfig.patrioticNameField.getData(),
                birthDate: uiConfig.patrioticNameField.getData(),
                
                location: uiConfig.locationField.getData(),
                email: uiConfig.emailField.getData(),
                phoneNumber: uiConfig.phoneField.getData(),
                
                avatarImage: uiConfig.avatarImageView.image
            )
            
            delegate?.safeToSave(with: userInfoToSave)
        } catch {
            if let saveError = error as? SaveError { delegate?.notSafeToSave(with: saveError) }
        }
        
    }
    
    
    @objc func handleVKButton() {
        delegate?.didTapVKButton()
    }
}


extension EditProfileInfoContainerView: EditProfileNavbarViewDelegate, ProfileAvatarViewDelegate {
 
    
    func didTapBackButton() {
        delegate?.didTapBackButton()
    }
    
    
    func didTapOnCameraButton() {
        delegate?.didTapAvatarImage()
    }
}
