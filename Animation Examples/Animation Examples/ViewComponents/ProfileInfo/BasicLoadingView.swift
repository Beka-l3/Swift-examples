//
//  BasicLoadingView.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 13.02.2024.
//

import UIKit


final class BasicLoadingView: UIView {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.tintColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init() {
        self.init(frame: .zero)
        alpha = 0
    }
}


extension BasicLoadingView {
    
    private func configure() {
        backgroundColor = .white.withAlphaComponent(Constants.viewAlpha)
        
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}


extension BasicLoadingView {
    
    func show(animated: Bool = true) {
        activityIndicator.startAnimating()
        
        if animated {
            UIView.animate(withDuration: Constants.animationDuration) { [unowned self] in
                self.alpha = 1
            }
        } else {
            alpha = 1
        }
    }
    
    func hide(animated: Bool = true) {
        activityIndicator.stopAnimating()
        
        if animated {
            UIView.animate(withDuration: Constants.animationDuration) { [unowned self] in
                self.alpha = 0
            }
        } else {
            alpha = 0
        }
    }
}


extension BasicLoadingView {
 
    enum Constants {
        
        static let viewAlpha:               CGFloat         = 0.7
        static let animationDuration:       TimeInterval    = 0.6
    }
}

