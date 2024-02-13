//
//  EditProfileInfoVCUIConfig.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 13.02.2024.
//

import UIKit


final class EditProfileInfoVCUIConfig {
    weak var rootView: UIView?
    
    
    lazy var gradientBgLayer = BgGradients.tfOrange.asLayer
}


extension EditProfileInfoVCUIConfig {
    
    func configureUI() {
        guard let rootView = rootView else { return }
        
        rootView.layer.addSublayer(gradientBgLayer)
        
    }
    
    func configureAutolayout() {
        guard let rootView = rootView else { return }
        
        NSLayoutConstraint.activate([
            
        ])
    }
    
    func configureFrames() {
        guard let rootView = rootView else { return }
        let size = CGSize(width: rootView.bounds.size.width, height: Constants.bgGradientHeight)
        gradientBgLayer.frame = .init(origin: .zero, size: size)
    }
}


extension EditProfileInfoVCUIConfig {
    
    func setAvatarImage(_ image: UIImage) {
//        containerView.setAvatarImage(image)
    }
    
    func setData(userInfo: UserInfo) {
//        containerView.setData(userInfo: userInfo)
    }
}


extension EditProfileInfoVCUIConfig {
 
    enum Constants {
        
        static let paddingL:                CGFloat     = 44
        static let bgGradientHeight:        CGFloat     = 400
    }
}

