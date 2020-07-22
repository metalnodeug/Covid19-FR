//
//  FavoriteCell.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 21/07/2020.
//

import UIKit

class FavoriteCell: UITableViewCell {

static let reuseID = "FavoriteCell"

    let name = CovTitleLabel()
    let code = CovTitleLabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(favorite: FavData) {
        self.name.text = favorite.name
        self.code.text = favorite.code
    }

    private func configure() {
        addSubviews(name,code)
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12

        NSLayoutConstraint.activate([
            name.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            name.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            name.heightAnchor.constraint(equalToConstant: 60),

            code.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            code.leadingAnchor.constraint(equalTo: name.trailingAnchor, constant: 24),
            code.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            code.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}