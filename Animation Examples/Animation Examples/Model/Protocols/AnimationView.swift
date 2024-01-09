//
//  AnimationView.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 09.01.2024.
//

import UIKit


protocol AnimationView: UIView, UIStyler {
    
    var isDescriptionHidden: Bool { get set }
    
    func startAnimation()
    
    func setupFrame()
    
}


extension AnimationView {
    
    func setupFrame() {
        frame = .init(
            origin: .zero,
            size: .init(width: GConstants.HIG.Size.screen.width, height: AnimationTableViewCell.animationViewHeight)
        )
    }
    
}

