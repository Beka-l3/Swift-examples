//
//  BubbleView.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 24.01.2024.
//

import UIKit


final class BubbleView: UIView {
    
    enum State {
        case small, large
    }
    
    var state: State
    
    var mainLabelYConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    
    
//    MARK: view components
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.labelTextColor
        label.font = Constants.mainLabelSmallFont
        label.text = Constants.mainLabelDefaultText
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var secondaryLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.labelTextColor
        label.font = Constants.secondaryLabelDefaultFont
        label.text = Constants.secondaryLabelDefaultText
        label.alpha = state == .small ? 0 : 1
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bgBoderView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.borderColor
        view.layer.cornerRadius = ((state == .small ? Constants.dimensionS : Constants.dimensionL) + Constants.borderWidth) / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
//    MARK: lifecycle
    init(state: State = .small, secondaryText: String = "") {
        self.state = state
        super.init(frame: .zero)
        
        setupView()
        self.secondaryLabel.text = secondaryText
    }
    
    required init?(coder: NSCoder) {
        self.state = .small
        super.init(coder: coder)
    }
    
    
//    MARK: private func
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = Constants.bgColor
        layer.cornerRadius = (state == .small ? Constants.dimensionS : Constants.dimensionL) / 2
        
        addSubview(bgBoderView)
        addSubview(mainLabel)
        addSubview(secondaryLabel)
        
        NSLayoutConstraint.activate([
            bgBoderView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bgBoderView.centerYAnchor.constraint(equalTo: centerYAnchor),
            bgBoderView.widthAnchor.constraint(equalTo: widthAnchor, constant: Constants.borderWidth),
            bgBoderView.heightAnchor.constraint(equalTo: heightAnchor, constant: Constants.borderWidth),
            
            mainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            secondaryLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: Constants.padding / 2),
            secondaryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        mainLabelYConstraint = mainLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: state == .small ? 0 : -Constants.padding)
        heightConstraint = heightAnchor.constraint(equalToConstant: state == .small ? Constants.dimensionS : Constants.dimensionL)
        widthConstraint = widthAnchor.constraint(equalToConstant: state == .small ? Constants.dimensionS : Constants.dimensionL)
        
        mainLabelYConstraint?.isActive = true
        heightConstraint?.isActive = true
        widthConstraint?.isActive = true
    }
    
}


extension BubbleView {
    
    enum Constants {
        
        static let labelTextColor: UIColor = .black
        
        static let mainLabelSmallFont = UIFont.systemFont(ofSize: 32, weight: .bold)
        static let secondaryLabelDefaultFont = UIFont.systemFont(ofSize: 10)
        
        static let mainLabelDefaultText = "0"
        static let mainLabelMoreThan999 = "999+"
        static let secondaryLabelDefaultText = "Lorem ipsum"
        
        static let dimensionL: CGFloat = 130
        static let dimensionS: CGFloat = 84
        
        static let bgColor: UIColor = .white
        static let borderColor: UIColor = UIColor(white: 1, alpha: 0.38)
        static let borderWidth: CGFloat = 22
        
        static let padding: CGFloat = 12
        
        static let mainLabelTransform: CGAffineTransform = CGAffineTransform(scaleX: 1.4, y: 1.4)
    }
    
}


extension BubbleView {
    
    func setData(_ mainText: Int, _ secondaryText: String? = nil) {
        
        switch mainText {
            
        case Int.min..<0:
            self.mainLabel.text = Constants.mainLabelDefaultText
            
        case 0...999:
            self.mainLabel.text = "\(mainText)"
            
        default:
            self.mainLabel.text = Constants.mainLabelMoreThan999
            
        }
        
        if let secondaryText = secondaryText {
            self.secondaryLabel.text = secondaryText
        }
    }
    
}


extension BubbleView {
    
    typealias void = () -> Void
    
    func getChangeStateAnimationKeyFrames(_ state: State? = nil) -> void {
        
        if let state = state {
            self.state = state
        } else {
            self.state = self.state == .small ? .large : .small
        }
        
        return getStateDidChangeAnimationKeyFrames()
    }
    
    private func getStateDidChangeAnimationKeyFrames() -> void  {
        let alpha: CGFloat = state == .small ? 0 : 1
        let bgCornerRadius: CGFloat = ((state == .small ? Constants.dimensionS : Constants.dimensionL) + Constants.borderWidth) / 2
        let cornerRadius: CGFloat = (state == .small ? Constants.dimensionS : Constants.dimensionL) / 2
        let dimension: CGFloat = state == .small ? Constants.dimensionS : Constants.dimensionL
        let padding: CGFloat = state == .small ? 0 : -Constants.padding
        let labelTransform: CGAffineTransform = state == .small ? .identity : Constants.mainLabelTransform
        
        let stateChangeClosure = { [unowned self] in
            self.heightConstraint?.constant = dimension
            self.widthConstraint?.constant = dimension
            self.mainLabelYConstraint?.constant = padding
            self.mainLabel.transform = labelTransform
            
            self.secondaryLabel.alpha = alpha
            self.layer.cornerRadius = cornerRadius
            self.bgBoderView.layer.cornerRadius = bgCornerRadius
            
            self.layoutIfNeeded()
        }
        
        return stateChangeClosure
    }
}


