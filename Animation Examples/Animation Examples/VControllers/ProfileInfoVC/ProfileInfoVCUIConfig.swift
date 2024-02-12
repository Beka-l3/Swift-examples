//
//  ProfileInfoVCUIConfig.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 12.02.2024.
//

import UIKit


final class ProfileInfoVCUIConfig {
    
    weak var rootView: UIView?
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .clear
        view.bounces = false
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var gradientBgLayer = BgGradients.tfOrange.asLayer
    
//    lazy var containerView = _ProfileInfoContainerView()
}


extension ProfileInfoVCUIConfig {
    
    func configureUI() {
        guard let rootView = rootView else { return }
        rootView.backgroundColor = .white
        
        rootView.layer.addSublayer(gradientBgLayer)
        rootView.addSubview(scrollView)
        
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
            
//            containerView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
//            containerView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
//            containerView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
//            
//            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
        
    }
    
    func configureFrames() {
        guard let rootView = rootView else { return }
        let size = CGSize(width: rootView.bounds.size.width, height: Constants.bgGradientHeight)
        gradientBgLayer.frame = .init(origin: .zero, size: size)
    }
}


extension ProfileInfoVCUIConfig {
    func setNameAndLocation(name: String, location: String) {
//        containerView.setNameAndLocation(name: name, location: location)
    }
    
    func setDiscount(_ newValue: Int) {
//        containerView.setDiscount(newValue)
    }
    
//    func setStatisticsItems(_ items: [_ProfileStatisticsView.StatisticsItem]) {
//        containerView.setStatisticsItems(items)
//        rootView?.layoutIfNeeded()
//    }
    
//    func setInfoDetails(type: _ProfileInfoDetailsView.InfoType, texts: _ProfileInfoDetailsView.InfoType.CaptionTexts) {
//        containerView.setInfoDetails(type: type, texts: texts)
//    }
    
    func setAvatar(_ image: UIImage) {
//        containerView.setAvatar(image)
    }
    
    func setAvatar(with url: String) {
//        containerView.setAvatar(with: url)
    }
    
}


extension ProfileInfoVCUIConfig {
 
    enum Constants {
        
        static let paddingS:                CGFloat     = 8
        static let padding:                 CGFloat     = 12
        static let bgGradientHeight:        CGFloat     = 400
    }
}
