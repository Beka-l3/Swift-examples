//
//  UIColor+Hex.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 12.02.2024.
//

import UIKit



extension UIColor {
    
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        let hexx: String
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            hexx = String(hex[start...])
        } else {
            hexx = hex
        }
        
        let hexColor = hexx.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        
        if hexColor.count == 8 {
            
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0

            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                a = CGFloat(hexNumber & 0x000000ff) / 255

                self.init(red: r, green: g, blue: b, alpha: a)
                return
            }
            
        } else if hexColor.count == 6 {
            
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0

            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255

                self.init(red: r, green: g, blue: b, alpha: 1)
                return
            }
        }

        return nil
    }
}

