//
//  GConstnats+HIG.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 05.01.2024.
//

import UIKit


extension GConstants {
    enum HIG {
        
    }
}


extension GConstants.HIG {
    enum Size {
        
        static let screen = UIScreen.main.bounds
        
        static let navbarLarge: CGSize = .init(width: screen.width, height: 97)
        
        static let statusbar: CGSize = .init(width: screen.width, height: 44)
        
        static let tabbar: CGSize = .init(width: screen.width, height: 49)
        
        static let homeIndicator: CGSize = .init(width: screen.width, height: 34)
    }
}


extension GConstants.HIG {
    enum Padding {
        
        static let S: CGFloat = 10
        static let M: CGFloat = 16
        static let L: CGFloat = 20
        
    }
}


extension GConstants.HIG.Padding {
    enum Four {
        
        static let x1: CGFloat = 4
        static let x2: CGFloat = 8
        static let x3: CGFloat = 12
        static let x4: CGFloat = 16
        static let x5: CGFloat = 20
        static let x6: CGFloat = 24
        static let x7: CGFloat = 28
        static let x8: CGFloat = 32
        static let x9: CGFloat = 36
        static let x10: CGFloat = 40
        static let x11: CGFloat = 44
        static let x12: CGFloat = 48
        
    }
}


extension GConstants.HIG.Padding {
    enum Eight {
        
        static let x1: CGFloat = 8
        static let x2: CGFloat = 16
        static let x3: CGFloat = 24
        static let x4: CGFloat = 32
        static let x5: CGFloat = 40
        static let x6: CGFloat = 48
        static let x7: CGFloat = 56
        static let x8: CGFloat = 64
        static let x9: CGFloat = 72
        static let x10: CGFloat = 80
        static let x11: CGFloat = 88
        static let x12: CGFloat = 96
        
    }
}
