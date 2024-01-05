//
//  RootVCTableViewCells.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 28.12.2023.
//

import UIKit


final class RootVCTableViewCell: UITableViewCell {
    
    static let identifier = "RootVCTableViewCellId"
    
    
    
//    MARK: lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
//    MARK: private func
    private func setupView() {
        
    }
    
}
