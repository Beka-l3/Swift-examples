//
//  Fonts.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 04.01.2024.
//

import UIKit


enum Fonts {
    
    static let titleLarge: UIFont = .systemFont(ofSize: 34, weight: .bold)
    static let title1: UIFont = .systemFont(ofSize: 28, weight: .bold)
    static let title2: UIFont = .systemFont(ofSize: 22, weight: .bold)
    
    static let headline: UIFont = .systemFont(ofSize: 17, weight: .medium)
    static let body: UIFont = .systemFont(ofSize: 17, weight: .regular)
    static let callout: UIFont = .systemFont(ofSize: 16, weight: .regular)
    static let subheadline: UIFont = .systemFont(ofSize: 15, weight: .regular)
    static let subheadlineBlack: UIFont = .systemFont(ofSize: 15, weight: .black)
    
    static let footnote: UIFont = .systemFont(ofSize: 13, weight: .medium)
    static let caption1: UIFont = .systemFont(ofSize: 12, weight: .regular)
    static let caption2: UIFont = .systemFont(ofSize: 11, weight: .regular)
    
    enum Height {
        static let titleLarge: CGFloat = 41
        static let title1: CGFloat = 34
        static let title2: CGFloat = 28
        
        static let headline: CGFloat = 22
        static let body: CGFloat = 22
        static let callout: CGFloat = 21
        static let subheadline: CGFloat = 20
        
        static let footnote: CGFloat = 18
        static let caption1: CGFloat = 16
        static let caption2: CGFloat = 13
    }
    
}


extension Fonts {
    
    enum Odachi {
        
        private static let title = "Odachi"
        
        static let regular16 = UIFont(name: title, size: 16)
        static let regular24 = UIFont(name: title, size: 24)
        static let regular36 = UIFont(name: title, size: 36)
        
        static let titleLarge = UIFont(name: title, size: 34)
        static let title1 = UIFont(name: title, size: 28)
        static let title2 = UIFont(name: title, size: 22)
        
        static let body = UIFont(name: title, size: 17)
        static let callout = UIFont(name: title, size: 16)
        static let subheadline = UIFont(name: title, size: 15)
        
        static let footnote = UIFont(name: title, size: 13)
        static let caption1 = UIFont(name: title, size: 12)
        static let caption2 = UIFont(name: title, size: 11)
        
    }
    
}
