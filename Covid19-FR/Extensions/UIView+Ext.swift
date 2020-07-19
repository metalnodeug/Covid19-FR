//
//  UIView+Ext.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 19/07/2020.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
