//
//  EditProfileInfoVC+ImagePicker.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 13.02.2024.
//

import UIKit
import Photos
import PhotosUI


extension EditProfileInfoVC {
    
    
    func openPHPicker() {
        var phPickerConfig = PHPickerConfiguration(photoLibrary: .shared())
        phPickerConfig.selectionLimit = 1
        phPickerConfig.filter = PHPickerFilter.any(of: [.images, .livePhotos])
        
        let phPickerVC = PHPickerViewController(configuration: phPickerConfig)
        phPickerVC.delegate = self
        
        present(phPickerVC, animated: true)
    }
    
    
    func openCamerVC() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.allowsEditing = true
            vc.cameraCaptureMode = .photo
            vc.modalPresentationStyle = .fullScreen
            vc.delegate = self
            
            present(vc, animated: true)
            
        } else {
            
            showAlert(type: .noCamera)
            
        }
    }
}


extension EditProfileInfoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            showAlert(type: .noImage)
            return
        }
        
        uiConfig.setAvatarImage(image)
    }
}


extension EditProfileInfoVC: PHPickerViewControllerDelegate {
    
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: .none)
        
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else { return }
                
                DispatchQueue.main.async { [weak self] in
                    self?.uiConfig.setAvatarImage(image)
                }
            }
        }
    }
}


