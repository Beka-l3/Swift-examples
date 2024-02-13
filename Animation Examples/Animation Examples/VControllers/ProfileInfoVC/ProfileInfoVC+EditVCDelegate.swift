//
//  ProfileInfoVC+EditVCDelegate.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 12.02.2024.
//

import UIKit


extension ProfileInfoVC: EditProfileInfoVCDelegate {
    
    
    func didTapSaveButton(with userInfoToSave: UserInfoToSave) {
//        #warning("Написать логику сохранений информаций профиля")
//        print(userInfoToSave)
        
        editVC?.startAnimatingLoad()
        Task {
            do { try await Task.sleep(nanoseconds: 3_000_000_000) } catch {}
            editVC?.pop()
        }
    }
    
    
    func didTapVKButton() {
//        #warning("Написать логику связывание профиля с ВК профилем")
        
        /*
         let userInfo = NetworkServie.getDataFromVK()
         editVC?.setData(userInfo: userInfo)
         */
    }
}

