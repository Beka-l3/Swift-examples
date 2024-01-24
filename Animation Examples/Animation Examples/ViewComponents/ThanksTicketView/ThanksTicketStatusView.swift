//
//  ThanksTicketStatusView.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 24.01.2024.
//

import UIKit


final class ThanksTicketStatusView: UIView {
    
    enum State: String {
        case notSent = "Не отправлен"
        case inProcess = "Выполняется"
        case canceled = "Отменён"
        case done = "Доставлено"
    }
    
    
//    MARK: exposed properties
    var state: State {
        didSet {
            stateLabel.text = state.rawValue
        }
    }
    
    
//    MARK: private properties
    private lazy var stateLabel: UILabel = {
        let label = UILabel()
        label.text = state.rawValue
        label.font = .systemFont(ofSize: 8)
        label.textColor = UIColor(red: 138/255, green: 138/255, blue: 138/255, alpha: 1)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
//    MARK: lifecycle
    init(state: State = .notSent) {
        self.state = state
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        self.state = .notSent
        super.init(coder: coder)
    }
    
    
//    MARK: private func
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = UIColor(red: 138/255, green: 138/255, blue: 138/255, alpha: 1).cgColor
        layer.cornerRadius = Constants.corderRadius
        
        addSubview(stateLabel)

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: Constants.viewWidth),
            heightAnchor.constraint(equalToConstant: Constants.viewHeight),
            
            stateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            stateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
}


extension ThanksTicketStatusView {
    enum Constants {
        static let viewHeight: CGFloat = 20
        static let viewWidth: CGFloat = 68
        static let corderRadius: CGFloat = 8
        static let borderWidth: CGFloat = 0.5
    }
}

