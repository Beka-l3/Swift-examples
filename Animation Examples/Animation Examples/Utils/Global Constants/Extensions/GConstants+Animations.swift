//
//  GConstants+Animations.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 05.01.2024.
//

import Foundation


extension GConstants {
    enum Animation {
        
    }
}

extension GConstants.Animation {
    enum Duration {
        
        static let standard: TimeInterval = 0.6
        
        static let short: TimeInterval = 0.4
        static let medium: TimeInterval = 1.2
        static let long: TimeInterval = 2
        
    }
}

extension GConstants.Animation.Duration {
    enum Splash {
        static let total: TimeInterval = 1.4
        static let part1: TimeInterval = 1
        static let part2: TimeInterval = 0.4
    }
    
    enum MyNavigationController {
        
        static let updateStyle: TimeInterval = 0.6
        
    }
}


extension GConstants.Animation.Duration {
    
    enum Triplet {
        
        static let unit: TimeInterval = 1 / 3
        
        static let firstPartStart: TimeInterval = unit * 0
        static let secondPartStart: TimeInterval = unit * 1
        static let thirdPartStart: TimeInterval = unit * 2
        
    }
    
}
