//
//  ThanksTicketViewComponents.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 24.01.2024.
//

import UIKit


final class ThanksTicketViewComponents {
    
    
    lazy var bgCover: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.bgCoverColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var ticketDetailsView = ThanksTicketDetailsView()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .gray
        button.layer.cornerRadius = Constants.cancelButtonDimension / 2
        
        button.setImage(UIImage(named: "Cancel Button"), for: .normal)
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: Constants.cancelButtonDimension),
            button.widthAnchor.constraint(equalToConstant: Constants.cancelButtonDimension),
        ])
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
//    MARK: exposed func
    func setupViews(parent: UIView) {
        parent.translatesAutoresizingMaskIntoConstraints = false
        
        parent.addSubview(bgCover)
        parent.addSubview(ticketDetailsView)
        parent.addSubview(cancelButton)
        
        setupConstraints(parent: parent)
    }
    
    func setupLayers(parent: UIView) {
        
    }
    
}


extension ThanksTicketViewComponents {
    private func setupConstraints(parent: UIView) {
        NSLayoutConstraint.activate([
            bgCover.topAnchor.constraint(equalTo: parent.topAnchor),
            bgCover.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            bgCover.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
            bgCover.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
            
            ticketDetailsView.centerXAnchor.constraint(equalTo: parent.centerXAnchor),
            ticketDetailsView.centerYAnchor.constraint(equalTo: parent.centerYAnchor),
            
            cancelButton.topAnchor.constraint(equalTo: ticketDetailsView.bottomAnchor, constant: Constants.paddingL),
            cancelButton.centerXAnchor.constraint(equalTo: parent.centerXAnchor),
        ])
    }
}


extension ThanksTicketViewComponents {
    enum Constants {
        static let paddingL: CGFloat = 30
        static let cancelButtonDimension: CGFloat = 36
        
        static let bgCoverColor: UIColor = UIColor(white: 0, alpha: 0.6)
    }
}
