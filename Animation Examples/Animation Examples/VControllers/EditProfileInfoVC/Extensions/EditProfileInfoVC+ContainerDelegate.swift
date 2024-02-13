//
//  EditProfileInfoVC+ContainerDelegate.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 13.02.2024.
//

import UIKit


extension EditProfileInfoVC: EditProfileInfoContainerViewDelegate {
    
    func safeToSave(with userInfoToSave: UserInfoToSave) {
        delegate?.didTapSaveButton(with: userInfoToSave)
    }
    
    
    func didTapVKButton() {
        delegate?.didTapVKButton()
    }
    
    
    func notSafeToSave(with error: EditProfileInfoContainerView.SaveError) {
        showAlert(type: .notSafeToSave(error: error))
    }
    
    
    func didTapAvatarImage() {
        showAlert(type: .pickImagePickMethod)
    }
    
    
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}


