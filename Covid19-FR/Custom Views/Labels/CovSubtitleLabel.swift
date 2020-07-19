//
//  CovSubtitleLabel.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 19/07/2020.
//

import UIKit

class CovSubtitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        textAlignment = .left
        textColor = .label
        numberOfLines = 2
        font = UIFont.boldSystemFont(ofSize: 16)
    }

}
