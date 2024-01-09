//
//  RootViewController+UITableView.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 28.12.2023.
//

import UIKit


extension RootViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Service.calculator.calculateHeight(for: animationVCs[indexPath.row].details)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        animationVCs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: RootVCTableViewCell.identifier) as? RootVCTableViewCell {
            
            cell.setData(details: animationVCs[indexPath.row].details)
            cell.updateStyle(to: traitCollection.userInterfaceStyle)
            
            return cell
            
        } else {
            
            return RootVCTableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        appCoordinator?.pushVC( animationVCs[indexPath.row] )
    }
}
