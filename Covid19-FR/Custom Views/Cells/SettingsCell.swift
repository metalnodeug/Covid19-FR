//
//  SettingsCell.swift
//  Covid19-FR
//
//  Created by metalnodeug on 24/07/2020.
//

import UIKit

enum CellType {
    case purchase, restore
}

class SettingsCell: UITableViewCell {

static let reuseID = "SettingsCell"

    var icon = UIImageView()
    var descriptionMessage = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(cellType: CellType) {
        switch cellType {
        case .purchase:
            self.icon.image = SFSymbols.purchase
            self.descriptionMessage.text = "Retirer les publicités"
        case .restore:
            self.icon.image = SFSymbols.restore
            self.descriptionMessage.text = "Restaurer les achats"
        }
    }

    private func configure() {
        self.addSubviews(icon, descriptionMessage)
        icon.translatesAutoresizingMaskIntoConstraints = false
        descriptionMessage.translatesAutoresizingMaskIntoConstraints = false

        icon.contentMode = .scaleAspectFill
        icon.tintColor = .systemGreen

        accessoryType = .disclosureIndicator
        let padding: CGFloat = 15

        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            icon.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            icon.heightAnchor.constraint(equalToConstant: 30),
            icon.widthAnchor.constraint(equalToConstant: 30),

            descriptionMessage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            descriptionMessage.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: padding),
            descriptionMessage.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -padding),
            descriptionMessage.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
