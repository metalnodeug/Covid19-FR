//
//  CovButton.swift
//  Covid19-FR
//
//  Created by metalnodeug on 25/07/2020.
//

import UIKit

class CovButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        backgroundColor = .systemGreen
    }

    func set(title: String) {
        self.setTitle(title, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    }

}
