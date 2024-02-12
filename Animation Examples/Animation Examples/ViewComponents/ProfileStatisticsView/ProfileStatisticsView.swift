//
//  ProfileStatisticsView.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 12.02.2024.
//

import UIKit


final class ProfileStatisticsView: UIView {
    
    enum StatisticsItem {
        case item(title: String, percent: Int, gradient: BgGradients)
    }
    
    private(set) var items: [StatisticsItem] = []
    private(set) var itemViews: [ProfileStatisticsItemView] = []
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.clipsToBounds = true
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = Constants.paddingXS
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
//    MARK: lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureAutolayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
}


extension ProfileStatisticsView {
    
    private func configure() {
        backgroundColor = .white
        layer.cornerRadius = Constants.cornerRadius
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = Constants.shadowOffset
        layer.shadowOpacity = Constants.shadowOpacity
        layer.shadowRadius = Constants.shadowRadius
        
        addSubview(stackView)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureAutolayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.paddingS),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.paddingS),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.paddingS),
            
            bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: Constants.padding)
        ])
    }
}


extension ProfileStatisticsView {
    
    func setItems(_ items: [StatisticsItem]) {
        self.items = items
        self.itemViews.forEach { $0.removeFromSuperview() }
//        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for item in items {
            addArrangedSubview(with: item)
        }
    }
    
    func addItem(_ item: StatisticsItem) {
        self.items.append(item)
        addArrangedSubview(with: item)
    }
}


extension ProfileStatisticsView {
    
    private func addArrangedSubview(with item: StatisticsItem) {
        
        switch item {
        
        case let .item(title, percent, gradient):
            let siv = ProfileStatisticsItemView(title: title + " \(percent)%", with: gradient)
            stackView.addArrangedSubview(siv)
            itemViews.append(siv)
            
        }
    }
}


extension ProfileStatisticsView {
    
    enum Constants {
        
        static let shadowOpacity:       Float       = 0.1
        
        static let paddingXXS:          CGFloat     = 4
        static let paddingXS:           CGFloat     = 8
        static let paddingS:            CGFloat     = 12
        static let padding:             CGFloat     = 16
        
        static let defaultHeight:       CGFloat     = 2 * paddingS
        
        static let cornerRadius:        CGFloat     = 12
        
        static let labelFontSize:       CGFloat     = 14
        static let labelHeight:         CGFloat     = 20
        
        static let shadowRadius:        CGFloat     = 8
        static let shadowOffset:        CGSize      = .init(width: 0, height: 8)
    }
}

