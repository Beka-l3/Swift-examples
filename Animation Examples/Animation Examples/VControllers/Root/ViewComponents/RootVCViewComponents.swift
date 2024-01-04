//
//  RootVCViewComponents.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 28.12.2023.
//

import UIKit


final class RootVCViewComponents {
    
    lazy var splashView = SplashAnimationView()
    
    lazy var navigationTableView: UITableView = {
        let view = UITableView()
        view.register(RootVCTableViewCell.self, forCellReuseIdentifier: RootVCTableViewCell.identifier)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
}


extension RootVCViewComponents: BaseViewComponents {
    
    func setupViews(parent: UIView) {
        parent.backgroundColor = .black
        
        parent.addSubview(navigationTableView)
        parent.addSubview(splashView)
        
        setupConstraints(parent: parent)
    }
    
}

extension RootVCViewComponents {
    
    func setupConstraints(parent: UIView) {
        
        NSLayoutConstraint.activate([
            navigationTableView.topAnchor.constraint(equalTo: parent.topAnchor),
            navigationTableView.leadingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.leadingAnchor),
            navigationTableView.trailingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.trailingAnchor),
            navigationTableView.bottomAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
    
}
