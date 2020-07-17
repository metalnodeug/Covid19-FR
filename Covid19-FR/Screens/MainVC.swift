//
//  MainVC.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 17/07/2020.
//

import UIKit
import Foundation

class MainVC: UIViewController {

    let flagImageView = UIImageView()
    let logoImageView = UIImageView()
    let entryTextField = UITextField()
    let actionButton = UIButton()

    let department = Department()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
    }

    private func configureUI() {
        configure_flagImageView()
        configure_logoImageView()
        configure_actionButton()
    }

    private func configure_flagImageView() {
        view.addSubview(flagImageView)
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        flagImageView.image = UIImage(named: "SantePubFR")

        NSLayoutConstraint.activate([
            flagImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            flagImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            flagImageView.widthAnchor.constraint(equalToConstant: 60),
            flagImageView.heightAnchor.constraint(equalToConstant: 34),
        ])

    }

    private func configure_logoImageView() {
        view.addSubview(logoImageView)
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "CovidLogo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor)
        ])
    }

    private func configure_actionButton() {
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false

        actionButton.setTitle("Rechercher", for: .normal)
        actionButton.tintColor = .systemBlue
        actionButton.backgroundColor = .systemGreen
        actionButton.layer.cornerRadius = 10
        actionButton.addTarget(self, action: #selector(searchAction), for: .touchUpInside)

        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
        ])
    }

    @objc private func searchAction() {

        for (key, value) in department.code.sorted(by: <) {
            print("\(key) - \(value)")
        }
    }

}
