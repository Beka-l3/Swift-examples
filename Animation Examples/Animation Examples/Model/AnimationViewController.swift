//
//  AnimationViewController.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 05.01.2024.
//

import UIKit


struct AnimatoinViewControllerDetails {
        
        let title: String
        
        let description: String
        
}

protocol AnimatoinViewController: UIViewController {
    
    var details: AnimatoinViewControllerDetails { get }
    
    var appCoordinator: AppCoordinator? { get set }
    
}

