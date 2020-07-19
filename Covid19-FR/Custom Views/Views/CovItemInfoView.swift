//
//  CovItemInfoView.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 18/07/2020.
//

import UIKit

enum ItemInfoView {
    case death,healed,hospitalized,intensiveCare
}

class CovItemInfoView: UIView {

    let symbolImageView = UIImageView()
    let countLabel = UILabel()
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        addSubviews(symbolImageView,countLabel,titleLabel)

        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label

        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),

            countLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            countLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 20),
            countLabel.heightAnchor.constraint(equalToConstant: 40),
            countLabel.widthAnchor.constraint(equalToConstant: 75),

            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
        ])
    }

    func set(with item: ItemInfoView, withCount count: Int, delta: Int? = nil) {
        countLabel.text = String(count)

        switch item {
            case .death:
                symbolImageView.image = SFSymbols.death
                titleLabel.text = "Décés"
            case .healed:
                symbolImageView.image = SFSymbols.heald
                titleLabel.text = "Guéris"
            case.hospitalized:
                symbolImageView.image = SFSymbols.hospitalized
                titleLabel.text = "Hospitalisés"
                if let delta = delta {
                    countLabel.text! += returnDelta(for: delta)
                }
            case .intensiveCare:
                symbolImageView.image = SFSymbols.intensiveCare
                titleLabel.text = "Réanimation"
                if let delta = delta {
                    countLabel.text! += returnDelta(for: delta)
                }
        }
    }

    private func returnDelta(for element: Int) -> String {
        var value: String

        if element == 0 {
            value = " (=)"
        } else if element > 0 {
            value = " (+\(element))"
        } else {
            value = ""
        }
        return value
    }
}



