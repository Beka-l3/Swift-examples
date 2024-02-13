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
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .clear
        view.bounces = false
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var loadingView: BasicLoadingView = .init()
}


extension EditProfileInfoVCUIConfig {
    
    func configureUI() {
        guard let rootView = rootView else { return }
        
        rootView.layer.addSublayer(gradientBgLayer)
        rootView.addSubview(scrollView)
//        rootView.addSubview(loadingView)
        
//        scrollView.addSubview(containerView)
        
    }
    
    func configureAutolayout() {
        guard let rootView = rootView else { return }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: rootView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: rootView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: rootView.bottomAnchor),
            
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
//            containerView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: Constants.paddingL),
//            containerView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
//            containerView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
//            
//            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            loadingView.topAnchor.constraint(equalTo: rootView.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: rootView.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: rootView.bottomAnchor),
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

