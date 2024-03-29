//
//  AppCoordinator.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 28.12.2023.
//

import UIKit


/// AppCoordinator For SceneDelegate
protocol AppCoordinatorForSceneDelegate {
    func setupScene(with window: UIWindow)
}


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


extension AppCoordinator: AppCoordinatorForSceneDelegate {
    
    func setupScene(with window: UIWindow) {        
        window.rootViewController = navigationController
    }
    
}


extension AppCoordinator {
    enum Mocks {
        static let animationVCs: [AnimatoinViewController] = [
            
            BasicAnimationsVC(
                details: .init(title: "Basic Animations", description: "Basic animations with signle sequence"),
                animationViews: [
                    BAVSingleSequence(type: .position),
                    BAVSingleSequence(type: .alpha),
                    BAVSingleSequence(type: .size),
                    BAVSingleSequence(type: .rotation),
                    BAVSingleSequence(type: .color),
                    BAVSingleSequence(type: .combined1),
                    BAVSingleSequence(type: .combined2),
                ]
            ),
            
            BasicAnimationsVC(
                details: .init(title: "Basic Animations", description: "Basic animations with multiple sequences"),
                animationViews: [
                    BAVMultipleSequences(type: .position),
                    BAVMultipleSequences(type: .alpha),
                    BAVMultipleSequences(type: .size),
                    BAVMultipleSequences(type: .rotation),
                    BAVMultipleSequences(type: .color),
                    BAVMultipleSequences(type: .combined1),
                    BAVMultipleSequences(type: .combined2),
                ]
            ),
            
            WaveAnimationVC(details: .init(title: "Wave Animation", description: "Grid of dots make a wave animation from center")),
            
            TFYViewController(details: .init(title: "TFYViewController", description: "Custom top bar with animating bubbles and Custom Ticket View with animated appearence")),
            
        ]
    }
}
