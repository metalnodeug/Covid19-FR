//
//  CovItemInfoVC.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 19/07/2020.
//

import UIKit

class CovItemInfoVC: UIViewController {
    
    let stackView = UIStackView()
    let itemInfoViewOne = CovItemInfoView()
    let itemInfoViewTwo = CovItemInfoView()
    
    var covData: CovData!
    
    init(covData: CovData) {
        super.init(nibName: nil, bundle: nil)
        self.covData = covData
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        layoutUI()
        configureStackView()
    }
    
    private func configureStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func layoutUI() {
        view.addSubviews(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
}
