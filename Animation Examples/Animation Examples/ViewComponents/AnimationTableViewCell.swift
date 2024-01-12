//
//  AnimationTableViewCells.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 09.01.2024.
//

import UIKit


final class AnimationTableViewCell: UITableViewCell {
    
    
//    MARK: static properties
    static let identifier = "AnimationTableViewCellId"
    static let animationViewHeight: CGFloat = 144
        
    
//    MARK: viewComponents
    var animationView: AnimationView? {
        didSet {
            if let animationView = animationView {
                addSubview(animationView)
            }
        }
    }
    
    
//    MARK: lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
//    MARK: exposed func
    func setAnimationView(_ view: AnimationView) {
        animationView = view
    }
    
    
//    MARK: private func
    private func setupView() {
        setStyle(animated: false)
        
        backgroundColor = .clear
    }
    
}


extension AnimationTableViewCell: UIStyler {
    
    func setStyle(_ style: UIUserInterfaceStyle = .dark, animated: Bool = true) {
        animationView?.setStyle(style, animated: animated)
    }
    
}
