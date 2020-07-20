//
//  CovDateLabel.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 19/07/2020.
//

import UIKit

class CovDateLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure_date()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure_date() {
        textAlignment = .center
        textColor = .secondaryLabel
        numberOfLines = 2
        font = UIFont.boldSystemFont(ofSize: 14)
    }

}
