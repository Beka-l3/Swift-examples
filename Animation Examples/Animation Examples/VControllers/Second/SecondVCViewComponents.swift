//
//  SecondVCViewComponents.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 13.01.2024.
//

import UIKit


final class SecondVCViewComponents {
    
    lazy var gridOfPolkDots = PolkDotGridView(polkDotSize: .small)
    
    lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.setTitle("Animate", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        
        button.frame = .init(
            x: GConstants.HIG.Size.screen.width  / 2 - 75,
            y: GConstants.HIG.Size.screen.height - 100,
            width: 150,
            height: 50
        )
        
        return button
    }()
    
    
}


extension SecondVCViewComponents: BaseViewComponents {
    
    func setupViews(parent: UIView) {
        parent.addSubview(gridOfPolkDots)
        parent.addSubview(button)
        
        setupConstraints(parent: parent)
    }
}


extension SecondVCViewComponents: UIStyler {
    
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


extension SecondVCViewComponents {
    
    func setupConstraints(parent: UIView) {
        NSLayoutConstraint.activate([
            gridOfPolkDots.topAnchor.constraint(equalTo: parent.topAnchor),
            gridOfPolkDots.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            gridOfPolkDots.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
            gridOfPolkDots.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
        ])
    }
    
}
