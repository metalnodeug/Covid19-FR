//
//  PurchaseVC.swift
//  Covid19-FR
//
//  Created by metalnodeug on 24/07/2020.
//

import UIKit

class PurchaseVC: UIViewController {

    let imageView = UIImageView()
    let priceLabel = UILabel()
    let purchaseLabel = UILabel()
    let purchaseButton = CovButton()
    let restoreButton = UIButton()

    let padding: CGFloat = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure_UI()
    }

    private func configure_UI() {
        configure_imageView()
        configure_priceLabel()
        configure_purchaseLabel()
        configure_purchaseButton()
        configure_restoreButton()
    }

    private func configure_imageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.image = CovImages.removeAdLogo
        imageView.clipsToBounds = true

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -padding*2),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150),
        ])
    }

    private func configure_priceLabel() {
        view.addSubview(priceLabel)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false

        priceLabel.text = "1,99€ seulement"
        priceLabel.textColor = .link
        priceLabel.font = UIFont.boldSystemFont(ofSize: 20)

        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    private func configure_purchaseLabel() {
        view.addSubview(purchaseLabel)
        purchaseLabel.translatesAutoresizingMaskIntoConstraints = false

        purchaseLabel.text = "Si vous souhaitez retirer les publicités et soutenir mon travail.\n Achat unique."
        purchaseLabel.numberOfLines = 3
        purchaseLabel.textAlignment = .center

        NSLayoutConstraint.activate([
            purchaseLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: padding),
            purchaseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            purchaseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            purchaseLabel.heightAnchor.constraint(equalToConstant: 80),
        ])
    }

    private func configure_purchaseButton() {
        view.addSubview(purchaseButton)
        purchaseButton.translatesAutoresizingMaskIntoConstraints = false

        purchaseButton.set(title: "Supprimer maintenant")
        purchaseButton.addTarget(self, action: #selector(purchaseAction), for: .touchUpInside)

        NSLayoutConstraint.activate([
            purchaseButton.topAnchor.constraint(equalTo: purchaseLabel.bottomAnchor, constant: padding),
            purchaseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            purchaseButton.heightAnchor.constraint(equalToConstant: 50),
            purchaseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            purchaseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
        ])
    }

    @objc private func purchaseAction() {
        print("Purchase")
    }

    private func configure_restoreButton() {
        view.addSubview(restoreButton)
        restoreButton.translatesAutoresizingMaskIntoConstraints = false

        restoreButton.setTitle("Restaurer les achats", for: .normal)
        restoreButton.setTitleColor(.systemBlue, for: .normal)
        restoreButton.addTarget(self, action: #selector(restoreAction), for: .touchUpInside)

        NSLayoutConstraint.activate([
            restoreButton.topAnchor.constraint(equalTo: purchaseButton.bottomAnchor, constant: padding),
            restoreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            restoreButton.heightAnchor.constraint(equalToConstant: 20),
            restoreButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            restoreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
    }

    @objc private func restoreAction() {
        print("restore")
    }
}
