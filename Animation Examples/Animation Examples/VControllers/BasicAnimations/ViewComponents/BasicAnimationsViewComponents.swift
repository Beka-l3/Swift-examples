//
//  BasicAnimationsViewComponents.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 09.01.2024.
//

import UIKit


final class BasicAnimationsViewComponents {
    
    lazy var animationTableView: UITableView = {
        let view = UITableView()
        view.register(AnimationTableViewCell.self, forCellReuseIdentifier: AnimationTableViewCell.identifier)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
}


extension BasicAnimationsViewComponents: BaseViewComponents {
    
    func setupViews(style: UIUserInterfaceStyle, parent: UIView) {
        updateStyle(to: style, parent: parent, animated: false)
        
        parent.addSubview(animationTableView)
        
        setupConstraints(parent: parent)
    }
    
    func updateStyle(to style: UIUserInterfaceStyle, parent: UIView, animated: Bool) {
        
        if animated {
            UIView.animate(withDuration: GConstants.Animation.Duration.standard) { [unowned parent] in
                parent.backgroundColor = style == .light ? .white : .black
            }
        } else  {
            parent.backgroundColor = style == .light ? .white : .black
        }
        
    }
    
    
}


extension BasicAnimationsViewComponents {
    
    func setupConstraints(parent: UIView) {
        NSLayoutConstraint.activate([
            animationTableView.topAnchor.constraint(equalTo: parent.topAnchor),
            animationTableView.leadingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.leadingAnchor),
            animationTableView.trailingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.trailingAnchor),
            animationTableView.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
        ])
    }
    
}
