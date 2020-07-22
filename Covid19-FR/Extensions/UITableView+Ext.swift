//
//  UITableView+Ext.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 21/07/2020.
//

import UIKit

extension UITableView {

    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }

    func removedExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
