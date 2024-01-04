//
//  SplashAnimationView.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 04.01.2024.
//

import UIKit


protocol SplashAnimationViewDelegate: AnyObject {
    func finishedAnimation()
}


final class SplashAnimationView: UIView {
    
    weak var delegate: SplashAnimationViewDelegate?
    
    var title: String {
        didSet {
            titleLabel.text = title
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = title
        label.font = Fonts.Odachi.titleLarge
        label.textColor = .white
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var isAnimating: Bool
    
    
//    MARK: lifecycle
    init(title: String = "Animations") {
        self.title = title
        self.isAnimating = false
        
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        self.title = ""
        self.isAnimating = false
        
        super.init(coder: coder)
    }
    
    
    
//    MARK: private func
    private func setupView() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
}


extension SplashAnimationView {
    
    func startAnimation() {
        
    }
    
    func stopAnimation() {
        
    }
    
}
