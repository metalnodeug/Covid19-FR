//
//  CovLoadingVC.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 18/07/2020.
//

import UIKit

class CovLoadingVC: UIViewController {

    var containerLoadingView: UIView!

    func showLoadingView() {
        containerLoadingView = UIView(frame: view.bounds)
        view.addSubview(containerLoadingView)

        containerLoadingView.backgroundColor = .systemBackground
        containerLoadingView.alpha = 0

        UIView.animate(withDuration: 0.25) { self.containerLoadingView.alpha = 0.8 }

        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerLoadingView.addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerLoadingView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerLoadingView.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }

    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerLoadingView.removeFromSuperview()
            self.containerLoadingView = nil
        }
    }

    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = CovEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
