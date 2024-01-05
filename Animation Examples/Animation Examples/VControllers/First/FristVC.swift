//
//  FristVC.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 30.12.2023.
//

import UIKit


final class FirstVC: UIViewController {
    
    weak var appCoordinator: AppCoordinator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(white: 0.2, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "First VC"
        appCoordinator?.isLargeNavTitle = false
    }
    
}

