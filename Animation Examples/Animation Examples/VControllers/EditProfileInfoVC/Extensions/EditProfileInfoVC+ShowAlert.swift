//
//  EditProfileInfoVC+ShowAlert.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 13.02.2024.
//

import UIKit


extension EditProfileInfoVC {
    
    
    enum AlertType {
        case noCamera, noImage
        case pickImagePickMethod
        case notSafeToSave(error: EditProfileInfoContainerView.SaveError)
    }
    
    func showAlert(type: AlertType) {
        
        var title: String = ""
        var message: String = ""
        var style: UIAlertController.Style = .alert
        
        var actions: [UIAlertAction] = []
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let useCamera = UIAlertAction(title: "Использовать камеру", style: .default) { [weak self] (action) in self?.openCamerVC() }
        let chooseFromGallery = UIAlertAction(title: "Выбрать из галлереий", style: .default) { [weak self] (action) in self?.openPHPicker() }
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        
        switch type {
            
        case .noCamera:
            title = "No Camera"
            message = "Sorry, this device has no camera"
            actions.append(okAction)
            
        case .noImage:
            title = "No Image"
            message = "Sorry, could not upload the image"
            actions.append(okAction)
            
        case .pickImagePickMethod:
            title = "Выбрать фото"
            message = "Выберите откуда вы хотите выбрать фото"
            style = .actionSheet
            actions.append(useCamera)
            actions.append(chooseFromGallery)
            actions.append(cancelAction)
            
        case let .notSafeToSave(error):
            title = "Ошибка при сохраниний данных"
            message = error.rawValue
            actions.append(okAction)
            
        }
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions { alertVC.addAction(action) }
        
        present(alertVC, animated: true)
    }
    
}

