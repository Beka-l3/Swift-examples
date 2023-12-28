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
            
            
            
            return cell
            
        } else {
            
            return RootVCTableViewCell()
            
        }
    }
    
}
