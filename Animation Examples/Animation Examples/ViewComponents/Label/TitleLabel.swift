//
//  TitleLabel.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 12.02.2024.
//

import UIKit


final class TitleLabel: UILabel {
    
    enum TitleType {
        case first(alignment: NSTextAlignment)
        case secondary
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(type: TitleType, fontSize: CGFloat, textColor: UIColor = .black) {
        self.init(frame: .zero)
        
        var weight: UIFont.Weight = .regular
        
        switch type {
            
        case let .first(alignment):
            textAlignment = alignment
            
        case .secondary:
            weight = .light
            
        }
        
        self.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        self.textColor = textColor
    }
    
}


extension TitleLabel {
    
    private func configure() {
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}


