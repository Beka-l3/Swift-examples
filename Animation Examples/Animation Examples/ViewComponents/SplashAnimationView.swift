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
    
    var shouldDisappearAfterAnimating: Bool
    
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
        
        return label
    }()
    
    private var isAnimating: Bool
    
    
//    MARK: lifecycle
    init(title: String = Constants.defaultTitle) {
        self.shouldDisappearAfterAnimating = true
        self.title = title
        self.isAnimating = false
        
        super.init(
            frame: .init(
                origin: .zero,
                size: .init(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height
                )
            )
        )
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        self.shouldDisappearAfterAnimating = true
        self.title = Constants.defaultTitle
        self.isAnimating = false
        
        super.init(coder: coder)
    }
    
    
    
//    MARK: private func
    private func setupView() {
        addSubview(titleLabel)
        
        titleLabel.center = center
    }
    
}


extension SplashAnimationView {
    
    func startAnimation() {
        isAnimating =  true
        
        UIView.animate(withDuration: Constants.animationDuration) { // [unowned self] in
            
            
            
        } completion: { [unowned self] _ in
            
            self.delegate?.finishedAnimation()
            
            if self.shouldDisappearAfterAnimating {
                disappear()
            }
            
            self.isAnimating = false
            
        }
    }
    
    func stopAnimation() {
        
        
        
    }
    
}


extension SplashAnimationView {
    
    func appear(animated: Bool = false) {
        if animated {
            
            UIView.animate(withDuration: Constants.appearanceDuration) { [unowned self] in
                self.alpha = 1
            }
            
        } else {
            
            alpha = 1
            
        }
    }
    
    func disappear(animated: Bool = true) {
        if animated {

            UIView.animate(withDuration: Constants.appearanceDuration) { [unowned self] in
                self.alpha = 0
            }
            
        } else {
            
            alpha = 0
            
        }
    }
    
}


extension SplashAnimationView {
    
    enum Constants {
        static let defaultTitle = "Animations"
        
        static let animationDuration: TimeInterval = 1
        static let appearanceDuration: TimeInterval = 0.6
    }
    
}
