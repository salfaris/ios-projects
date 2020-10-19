//
//  UITableView+Ext.swift
//  GithubFollowers
//
//  Created by Salman Faris on 19/10/2020.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async { self.reloadData() }
    }
    
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
