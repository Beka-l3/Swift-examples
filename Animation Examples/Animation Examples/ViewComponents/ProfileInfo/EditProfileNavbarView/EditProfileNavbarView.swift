//
//  EditProfileNavbarView.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 13.02.2024.
//

import UIKit


protocol EditProfileNavbarViewDelegate: AnyObject {
    func didTapBackButton()
}


final class EditProfileNavbarView: UIView {
    
    weak var delegate: EditProfileNavbarViewDelegate?
    
    
    private lazy var titleView = TitleLabel(type: .first(alignment: .center), fontSize: 18, textColor: .black)
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setImage(GConstants.Images.backChevron, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureAutolayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        titleView.text = title
    }
}


extension EditProfileNavbarView {
    
    private func configure() {
        backgroundColor = .white
        
        addSubview(titleView)
        addSubview(backButton)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureAutolayout() {
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
            backButton.widthAnchor.constraint(equalToConstant: Constants.backButtonDimension),
            backButton.heightAnchor.constraint(equalToConstant: Constants.backButtonDimension),
            
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            heightAnchor.constraint(equalToConstant: Constants.viewHeight),
        ])
    }
}


extension EditProfileNavbarView {

    @objc func handleBackButton() {
        delegate?.didTapBackButton()
    }
}


extension EditProfileNavbarView {
    
    enum Constants {
        
        static let padding:                     CGFloat         = 18
        static let backButtonDimension:         CGFloat         = 50
        static let viewHeight:                  CGFloat         = 60
    }
}

