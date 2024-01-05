//
//  AppCoordinator+Navigation.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 30.12.2023.
//

import UIKit


extension AppCoordinator {
    
    func pushVC(_ vc: UIViewController) {
        navigationController.pushViewController(vc, animated: true)
    }
    
}

