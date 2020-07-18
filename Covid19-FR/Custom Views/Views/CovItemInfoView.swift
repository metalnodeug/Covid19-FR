//
//  CovItemInfoView.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 18/07/2020.
//

import UIKit

enum ItemInfoType {
    case global, scope
}

class CovItemInfoView: UIView {

    let symbolImageView = UIImageView()
    let titleLabel = UILabel()
    let countLabel = UILabel()

    let secondary_symbolImageView = UIImageView()
    let secondary_titleLabel = UILabel()
    let secondary_countLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        addSubview(symbolImageView)
        addSubview(countLabel)
        addSubview(titleLabel)

        addSubview(secondary_symbolImageView)
        addSubview(secondary_countLabel)
        addSubview(secondary_titleLabel)


        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        secondary_symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        secondary_countLabel.translatesAutoresizingMaskIntoConstraints = false
        secondary_titleLabel.translatesAutoresizingMaskIntoConstraints = false


        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label

        secondary_symbolImageView.contentMode = .scaleAspectFill
        secondary_symbolImageView.tintColor = .label

        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor,constant: 20),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),

            countLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            countLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 20),
            countLabel.heightAnchor.constraint(equalToConstant: 40),
            countLabel.widthAnchor.constraint(equalToConstant: 50),

            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),

            secondary_symbolImageView.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor,constant: 20),
            secondary_symbolImageView.leadingAnchor.constraint(equalTo: symbolImageView.leadingAnchor),
            secondary_symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            secondary_symbolImageView.heightAnchor.constraint(equalToConstant: 20),

            secondary_countLabel.centerYAnchor.constraint(equalTo: secondary_symbolImageView.centerYAnchor),
            secondary_countLabel.leadingAnchor.constraint(equalTo: secondary_symbolImageView.trailingAnchor, constant: 20),
            secondary_countLabel.heightAnchor.constraint(equalToConstant: 40),
            secondary_countLabel.widthAnchor.constraint(equalToConstant: 50),

            secondary_titleLabel.centerYAnchor.constraint(equalTo: secondary_symbolImageView.centerYAnchor),
            secondary_titleLabel.leadingAnchor.constraint(equalTo: secondary_countLabel.trailingAnchor, constant: 20),
            secondary_titleLabel.heightAnchor.constraint(equalToConstant: 40),
            secondary_titleLabel.widthAnchor.constraint(equalToConstant: 200),
        ])
    }

    func set(itemInfoType: ItemInfoType, withCount firstElementCount: Int, secondElementCount: Int) {
        switch itemInfoType {
        case .global:
            symbolImageView.image = SFSymbols.death
            titleLabel.text = "Décés"
            secondary_symbolImageView.image = SFSymbols.heeris
            secondary_titleLabel.text = "Guéris"
        case .scope:
            symbolImageView.image = SFSymbols.cross
            titleLabel.text = "Scope"
            secondary_symbolImageView.image = SFSymbols.death
            secondary_titleLabel.text = "Décés"
        }

        countLabel.text = String(firstElementCount)
        secondary_countLabel.text = String(secondElementCount)
    }
}
