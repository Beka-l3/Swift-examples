//
//  RootViewController+UITableView.swift
//  Animation Examples
//
//  Created by Bekzhan Talgat on 28.12.2023.
//

import UIKit


extension RootViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        animationViewControllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: RootVCTableViewCell.identifier) as? RootVCTableViewCell {
            
            cell.backgroundColor = [UIColor.systemRed, UIColor.systemGreen, UIColor.systemBlue][indexPath.row % 3]
            
            return cell
            
        } else {
            
            return RootVCTableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
            
        case 0:
            let fvc = FirstVC()
            fvc.appCoordinator = appCoordinator
            appCoordinator?.pushVC(fvc)
            
        case 1:
            appCoordinator?.setDefaultNavbarStyle()
            
        case 2:
            appCoordinator?.navBarStyle1()
            
        default:
            break
            
        }
        
    }
}
