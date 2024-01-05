//
//  RootViewController+UITableView.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 28.12.2023.
//

import UIKit


extension RootViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        58
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        animationViewControllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: RootVCTableViewCell.identifier) as? RootVCTableViewCell {
            
            cell.setData(details: animationViewControllers[indexPath.row].details)
            
            return cell
            
        } else {
            
            return RootVCTableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
            
        case 0:
            appCoordinator?.pushVC( animationViewControllers[0].vc )
            
        case 1:
            appCoordinator?.setDefaultNavbarStyle()
            
        case 2:
            appCoordinator?.navBarStyle1()
            
        default:
            break
            
        }
        
    }
}
