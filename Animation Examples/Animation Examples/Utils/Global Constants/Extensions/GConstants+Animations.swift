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
    
    enum AnimationView {
        
        static let fast: TimeInterval = 0.4
        static let less: TimeInterval = 1.2
        static let standard: TimeInterval = 2
        
    }
    
}
