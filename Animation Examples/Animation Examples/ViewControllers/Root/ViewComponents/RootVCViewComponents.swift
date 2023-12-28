//
//  RootVCViewComponents.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 28.12.2023.
//

import UIKit


final class RootVCViewComponents {
    
    lazy var navigationTableView: UITableView = {
        let view = UITableView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    
    
    
}


extension RootVCViewComponents: BaseViewComponents {
    
    func setupViews(parent: UIView) {
        parent.backgroundColor = .systemPurple
        
    }
    
}
