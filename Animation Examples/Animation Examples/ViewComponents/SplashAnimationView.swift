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
        
        label.translatesAutoresizingMaskIntoConstraints = false
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
        backgroundColor = .black
        layer.zPosition = Constants.zPosition
        
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        titleLabel.alpha = 0
    }
    
}


extension SplashAnimationView {
    
    func startAnimation() {
        isAnimating =  true
        
        UIView.animate(withDuration: Constants.animationDurationPart1) { [unowned self] in
            
            self.titleLabel.alpha = 1
            
        } completion: { [unowned self] _ in
            
            Timer.scheduledTimer(timeInterval: Constants.animationDurationPart2, target: self, selector: #selector(finishedAnimating), userInfo: nil, repeats: false)
            
        }
    }
    
    @objc func finishedAnimating() {
        delegate?.finishedAnimation()
        
        if shouldDisappearAfterAnimating {
            disappear()
        }
        
        isAnimating = false
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
        
        static let zPosition: CGFloat = 100
        
        static let animationDuration: TimeInterval = 1.4
        static let animationDurationPart1: TimeInterval = 1
        static let animationDurationPart2: TimeInterval = 0.4
        
        static let appearanceDuration: TimeInterval = 0.6
    }
    
}
