//
//  RootVCTableViewCells.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 28.12.2023.
//

import UIKit


final class RootVCTableViewCell: UITableViewCell {
    
    static let identifier = "RootVCTableViewCellId"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        label.numberOfLines = 1
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var animationVCDetails: AnimationVC.Details? {
        didSet {
            if let animationVCDetails = animationVCDetails {
                titleLabel.text = animationVCDetails.title
                descriptionLabel.text = animationVCDetails.description
            } else {
                titleLabel.text = Constants.titleTextDefault
                descriptionLabel.text = Constants.descriptionTextDefault
            }
        }
    }
    
    
//    MARK: lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
//    MARK: exposed func
    func setData(details: AnimationVC.Details) {
        self.animationVCDetails = details
    }
    
    
//    MARK: private func
    private func setupView() {
        backgroundColor = .clear
        
        accessoryType = .disclosureIndicator
        
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: GConstants.HIG.Padding.Four.x2),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: GConstants.HIG.Padding.Four.x5),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant:  -GConstants.HIG.Padding.Four.x2),
        ])
        
        if let accessoryView = accessoryView {
            NSLayoutConstraint.activate([
                titleLabel.trailingAnchor.constraint(equalTo: accessoryView.leadingAnchor),
                descriptionLabel.trailingAnchor.constraint(equalTo: accessoryView.leadingAnchor),
            ])
        } else {
            NSLayoutConstraint.activate([
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -GConstants.HIG.Padding.Four.x2),
                descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -GConstants.HIG.Padding.Four.x2),
            ])
        }
    }
    
}


extension RootVCTableViewCell {
    
    enum Constants {
        static let titleTextDefault = "Title"
        static let descriptionTextDefault = "Text that describes the View Controller"
        
    }

}
