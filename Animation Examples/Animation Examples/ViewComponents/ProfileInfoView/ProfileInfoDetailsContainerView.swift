//
//  ProfileInfoDetailsContainerView.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 12.02.2024.
//

import UIKit


final class ProfileInfoDetailsContainerView: UIView {
    
    private var topPadding: CGFloat
    
    private lazy var nameLabel              = _TitleLabel(type: .first(alignment: .center), fontSize: Constants.nameLabelFontSize)
    private lazy var locationLabel          = _TitleLabel(type: .first(alignment: .center), fontSize: Constants.locationLabelFontSize, textColor: .gray)
    private lazy var nameDetailsView        = _ProfileInfoDetailsView(type: .name)
    private lazy var contantsDetailsView    = _ProfileInfoDetailsView(type: .contants)
    private lazy var companyDetailsView     = _ProfileInfoDetailsView(type: .company)
    private lazy var statisticsView         = _ProfileStatisticsView()
    
    
//    MARK: lifeCycle
    init(topPadding: CGFloat) {
        self.topPadding = topPadding
        super.init(frame: .zero)
        configure()
        configureAutolayout()
    }
    
    required init?(coder: NSCoder) {
        self.topPadding = .zero
        super.init(coder: coder)
    }
}


extension ProfileInfoDetailsContainerView {
    private func configure() {
        layer.cornerRadius = Constants.cornerRadius
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        backgroundColor = .white
        
        addSubview(nameLabel)
        addSubview(locationLabel)
        addSubview(nameDetailsView)
        addSubview(contantsDetailsView)
        addSubview(companyDetailsView)
        addSubview(statisticsView)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureAutolayout() {
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: topPadding + Constants.paddingS),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: Constants.nameLabelheight),
            
            locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            locationLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: Constants.locationLabelheight),
            
            nameDetailsView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: Constants.paddingM),
            nameDetailsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
            nameDetailsView.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -Constants.padding / 2),
            
            contantsDetailsView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: Constants.paddingM),
            contantsDetailsView.leadingAnchor.constraint(equalTo: centerXAnchor, constant: Constants.padding / 2),
            contantsDetailsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding),
            
            companyDetailsView.topAnchor.constraint(equalTo: nameDetailsView.bottomAnchor, constant: Constants.padding),
            companyDetailsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
            companyDetailsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding),
            
            statisticsView.topAnchor.constraint(equalTo: companyDetailsView.bottomAnchor, constant: Constants.padding),
            statisticsView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding),
            statisticsView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding),
            
            bottomAnchor.constraint(equalTo: statisticsView.bottomAnchor, constant: Constants.paddingL),
        ])
    }
}


extension ProfileInfoDetailsContainerView {
    
    func setNameAndLocation(name: String, location: String) {
        nameLabel.text = name
        locationLabel.text = location
    }
    
    func setStatisticsItems(_ items: [_ProfileStatisticsView.StatisticsItem]) {
        statisticsView.setItems(items)
    }
    
    func setInfoDetails(type: _ProfileInfoDetailsView.InfoType, texts: _ProfileInfoDetailsView.InfoType.CaptionTexts) {
        switch type {
            
        case .name:
            nameDetailsView.setTitlesText(texts: texts)
            
        case .contants:
            contantsDetailsView.setTitlesText(texts: texts)
            
        case .company:
            companyDetailsView.setTitlesText(texts: texts)
            
        }
    }
}


extension ProfileInfoDetailsContainerView {
    
    enum Constants {
        
        static let cornerRadius:            CGFloat     = 24
        
        static let paddingS:                CGFloat     = 6
        static let padding:                 CGFloat     = 16
        static let paddingM:                CGFloat     = 24
        static let paddingL:                CGFloat     = 36
        
        static let nameLabelFontSize:       CGFloat     = 18
        static let nameLabelheight:         CGFloat     = 22
        static let locationLabelFontSize:   CGFloat     = 16
        static let locationLabelheight:     CGFloat     = 20
    }
}

