//
//  UIViewController+Ext.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 19/07/2020.
//

import UIKit

extension UIViewController {

    func presentCovAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: buttonTitle, style: .default) { _ in
                self.navigationController?.popViewController(animated: true)
            }
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            alertVC.addAction(OKAction)
            self.present(alertVC, animated: true)
        }
    }
}
