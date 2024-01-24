//
//  TFYVCViewComponents.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 24.01.2024.
//

import UIKit


final class TFYVCViewComponents {
    
    lazy var btn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Show ticket", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 19)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemOrange
        btn.layer.cornerRadius = 8
        NSLayoutConstraint.activate([
            btn.widthAnchor.constraint(equalToConstant: 180),
            btn.heightAnchor.constraint(equalToConstant: 60),
        ])
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
}


extension TFYVCViewComponents: BaseViewComponents {
    
    func setupViews(parent: UIView) {
        
        parent.addSubview(btn)
        
        setupConstraints(parent: parent)
        
    }
    
    func setupConstraints(parent: UIView) {
        NSLayoutConstraint.activate([
            btn.centerXAnchor.constraint(equalTo: parent.centerXAnchor),
            btn.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -200),
        ])
    }
}


extension TFYVCViewComponents: UIStyler {
    
    func setStyle(_ style: UIUserInterfaceStyle = .dark, parent: UIView, animated: Bool = true) {
        
        if animated {
            
            UIView.animate(withDuration: GConstants.Animation.Duration.standard) { [unowned parent] in
                parent.backgroundColor = style == .light ? .white : .black
            }
            
        } else  {
            
            parent.backgroundColor = style == .light ? .white : .black
            
        }
        
    }
    
}



