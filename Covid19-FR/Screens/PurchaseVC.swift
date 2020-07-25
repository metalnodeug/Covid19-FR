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
    let purchaseButton = UIButton()
    let restoreButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure_UI()

        imageView.image = CovImages.removeAdLogo
        imageView.clipsToBounds = true

        priceLabel.text = "1,99€"
        priceLabel.textColor = .link
        priceLabel.font = UIFont.boldSystemFont(ofSize: 20)

        purchaseLabel.text = "Si vous souhaitez retirer les publicités et soutenir mon travail.\n Achat unique."
        purchaseLabel.numberOfLines = 3
        purchaseLabel.textAlignment = .center

        purchaseButton.setTitle("Acheter", for: .normal)
        purchaseButton.backgroundColor = .systemGreen
        purchaseButton.layer.cornerRadius = 10
        purchaseButton.addTarget(self, action: #selector(purchaseAction), for: .touchUpInside)

        restoreButton.setTitle("Restaurer les achats", for: .normal)
        restoreButton.setTitleColor(.systemBlue, for: .normal)
    }

    @objc private func purchaseAction() {

    }

    private func configure_UI() {
        view.addSubviews(imageView,priceLabel,purchaseLabel,purchaseButton,restoreButton)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        purchaseLabel.translatesAutoresizingMaskIntoConstraints = false
        purchaseButton.translatesAutoresizingMaskIntoConstraints = false
        restoreButton.translatesAutoresizingMaskIntoConstraints = false

        let padding: CGFloat = 20

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -padding*2),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.widthAnchor.constraint(equalToConstant: 150),

            priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 40),

            purchaseLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: padding),
            purchaseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            purchaseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            purchaseLabel.heightAnchor.constraint(equalToConstant: 80),
            
            purchaseButton.topAnchor.constraint(equalTo: purchaseLabel.bottomAnchor, constant: padding),
            purchaseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            purchaseButton.heightAnchor.constraint(equalToConstant: 50),
            purchaseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            purchaseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),

            restoreButton.topAnchor.constraint(equalTo: purchaseButton.bottomAnchor, constant: padding),
            restoreButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            restoreButton.heightAnchor.constraint(equalToConstant: 20),
            restoreButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            restoreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
    }
    
}
