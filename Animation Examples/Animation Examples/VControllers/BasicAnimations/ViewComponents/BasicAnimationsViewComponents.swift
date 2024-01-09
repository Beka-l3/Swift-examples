//
//  BasicAnimationsViewComponents.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 09.01.2024.
//

import UIKit


final class BasicAnimationsViewComponents: BaseViewComponents {
    
    lazy var animationTableView: UITableView = {
        let view = UITableView()
        view.register(AnimationTableViewCell.self, forCellReuseIdentifier: AnimationTableViewCell.identifier)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    
    func setupViews(style: UIUserInterfaceStyle, parent: UIView) {
        
    }
    
    func updateStyle(to style: UIUserInterfaceStyle, parent: UIView, animated: Bool) {
        
    }
    
    func setupConstraints(parent: UIView) {
        
    }
    
}
