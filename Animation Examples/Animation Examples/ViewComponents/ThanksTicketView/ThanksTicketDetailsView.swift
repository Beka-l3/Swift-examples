//
//  ThanksTicketDetailsView.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 24.01.2024.
//

import UIKit


final class ThanksTicketDetailsView: UIView {
    
    private let viewComponents: ThanksTicketDetailsViewComponents = .init()
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
    
    private let timeFormatter: DateFormatter = {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        return timeFormatter
    }()
    
    
    
//    MARK: lifecycle
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayer()
    }
    
    
//    MARK: private func
    private func setupView() {
        viewComponents.setupView(parent: self)
    }
    
    private func setupLayer() {
        viewComponents.setupLayer(parent: self)
    }
    
}


extension ThanksTicketDetailsView {
    
    enum Constants {
        static let cornerRadius: CGFloat = 16
        
        static let viewWidth: CGFloat = 220
        static let viewHeight: CGFloat = 380
    }
    
}


extension ThanksTicketDetailsView {
    
    func setDate(date: Date) {
        viewComponents.dateLabel.text = dateFormatter.string(from: date)
        viewComponents.timeLabel.text = timeFormatter.string(from: date)
    }
    
    func setUserInfo(name: String, image: UIImage?) {
        viewComponents.usernameLabel.text = name
        
        if let image = image {
            
            viewComponents.avatarImageView.alpha = 1
            viewComponents.avatarImageView.image = image
            
        } else {
            
            viewComponents.avatarImageView.alpha = 0
            
        }
    }
    
    func setCount(_ count: Int) {
        switch count {
            
        case Int.min..<0:
            viewComponents.countLabel.text = "X"
            
        default:
            viewComponents.countLabel.text = "\(count)"
            
        }
    }
    
    func setState(_ state: ThanksTicketStatusView.State) {
        viewComponents.stateView.state = state
    }
    
}
