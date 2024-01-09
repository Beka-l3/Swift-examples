//
//  AppCoordinator.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 28.12.2023.
//

import UIKit


final class AppCoordinator {
    
    let rootViewController: RootViewController
    let navigationController: MyNavigationController
    

//    MARK: lifecycle
    init() {
        self.rootViewController = .init(animationVCs: Mocks.animationVCs)
        self.navigationController = .init(rootViewController: self.rootViewController)
        
        rootViewController.appCoordinator = self
        
        setupNavbar()
    }
       
}


/// AppCoordinator For SceneDelegate
protocol AppCoordinatorForSceneDelegate {
    func setupScene(with window: UIWindow)
}

extension AppCoordinator: AppCoordinatorForSceneDelegate {
    
    func setupScene(with window: UIWindow) {        
        window.rootViewController = navigationController
    }
    
}



extension AppCoordinator {
    enum Mocks {
        static let animationVCs = [
            BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions")),
            BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of")),
            BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable")),
            BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of")),
            BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView")),
            BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and")),
            BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer")),
            BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions")),
            BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of")),
            BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable")),
            BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable properties")),
            BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable properties of")),
            BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable properties of UIView")),
            BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable properties of UIView and")),
            BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable properties of UIView and CALayer")),
            BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable properties of UIView and CALayer. Animations")),
            BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable properties of UIView and CALayer. Animations of")),
            BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable properties of UIView and CALayer. Animations of animatable")),
            BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable properties of UIView and CALayer. Animations of animatable properties")),
            BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable properties of UIView and CALayer. Animations of animatable properties if UIView")),
            BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable properties of UIView and CALayer. Animations of animatable properties if UIView and")),
            BasicAnimationsVC(details: .init(title: "Basic Animations", description: "Animtions of animatable properties of UIView and CALayer. Animtions of animatable properties of UIView and CALayer. Animations of animatable properties if UIView and CAlayer")),
        ]
    }
}
