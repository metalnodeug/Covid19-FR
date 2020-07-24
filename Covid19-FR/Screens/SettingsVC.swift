//
//  SettingsVC.swift
//  Covid19-FR
//
//  Created by metalnodeug on 24/07/2020.
//

import UIKit

class SettingsVC: UIViewController {

    let versionLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configure_versionLabel()
    }
    
    private func configureViewController() {
           view.backgroundColor = .systemBackground
           navigationController?.setNavigationBarHidden(false, animated: true)
           navigationController?.navigationBar.prefersLargeTitles = true
           title = "Réglages"
       }

    private func configure_versionLabel() {
        view.addSubview(versionLabel)
        versionLabel.translatesAutoresizingMaskIntoConstraints = false

        versionLabel.text = "V1.0"
        versionLabel.textColor = .secondaryLabel
        versionLabel.font = UIFont.boldSystemFont(ofSize: 14)
        versionLabel.textAlignment = .right

        let padding: CGFloat = 15

        NSLayoutConstraint.activate([
            versionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            versionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            versionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            versionLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

}
