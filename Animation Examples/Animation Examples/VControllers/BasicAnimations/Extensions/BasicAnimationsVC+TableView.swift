//
//  BasicAnimationsVC+TableView.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 09.01.2024.
//

import UIKit


extension BasicAnimationsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        AnimationTableViewCell.animationViewHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        animationViews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: AnimationTableViewCell.identifier) as? AnimationTableViewCell {
            
            cell.setAnimationView(animationViews[indexPath.row])
            cell.setStyle(traitCollection.userInterfaceStyle)
            cell.animationView?.isDescriptionHidden = isDescriptionHidden
            
            return cell
            
        } else {
            
            return AnimationTableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath) as? AnimationTableViewCell {
            cell.animationView?.startAnimation()
        }
    }
    
}
