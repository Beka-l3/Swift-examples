//
//  BasicUIViewAnimate.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 09.01.2024.
//

import UIKit


protocol BasicUIViewAnimate: UIView, UIStyler {
    
    var isDescriptionHidden: Bool { get set }
    
    func startAnimation()
    
    func setupFrame()
    
}


extension BasicUIViewAnimate {
    
    func setupFrame() {
        frame = .init(
            origin: .zero,
            size: .init(width: GConstants.HIG.Size.screen.width, height: AnimationTableViewCell.animationViewHeight)
        )
    }
    
}

