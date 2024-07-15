//
//  UITableView +Ext.swift
//  Movie-App
//
//  Created by Marcos Fabian Chong Megchun on 10/07/24.
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
