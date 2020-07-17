//
//  MainVC.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 17/07/2020.
//

import UIKit
import Foundation

class MainVC: UIViewController {

    let flagImageView = UIImageView()
    let logoImageView = UIImageView()
    let textLabel = UILabel()
    let entryPickerView = UIPickerView()
    let actionButton = UIButton()

    let department = Department()
    var pickerSelection: String = "Bas-Rhin"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(true, animated: true)
        configureUI()
    }

    private func configureUI() {
        configure_flagImageView()
        configure_logoImageView()
        configure_textLabel()
        configure_entryPickerView()
        configure_actionButton()
    }

    private func configure_flagImageView() {
        view.addSubview(flagImageView)
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        flagImageView.image = UIImage(named: "SantePubFR")

        NSLayoutConstraint.activate([
            flagImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            flagImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            flagImageView.widthAnchor.constraint(equalToConstant: 60),
            flagImageView.heightAnchor.constraint(equalToConstant: 34),
        ])

    }

    private func configure_logoImageView() {
        view.addSubview(logoImageView)
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "CovidLogo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: 20),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor)
        ])
    }

    private func configure_textLabel() {
        view.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Veuillez selectionner un département:"
        textLabel.numberOfLines = 0
        textLabel.font = UIFont.boldSystemFont(ofSize: 17)

        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.heightAnchor.constraint(equalToConstant: 41),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }

    private func configure_entryPickerView() {
        view.addSubview(entryPickerView)
        entryPickerView.translatesAutoresizingMaskIntoConstraints = false
        entryPickerView.delegate = self
        entryPickerView.dataSource = self
        entryPickerView.selectRow(67, inComponent: 0, animated: false)

        NSLayoutConstraint.activate([
            entryPickerView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 10),
            entryPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            entryPickerView.heightAnchor.constraint(equalToConstant: 150),
            entryPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            entryPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }

    private func configure_actionButton() {
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false

        actionButton.setTitle("Rechercher", for: .normal)
        actionButton.tintColor = .systemBlue
        actionButton.backgroundColor = .systemGreen
        actionButton.layer.cornerRadius = 10
        actionButton.addTarget(self, action: #selector(searchAction), for: .touchUpInside)

        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: entryPickerView.bottomAnchor, constant: 10),
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
        ])
    }

    @objc private func searchAction() {
        NetworkManager.shared.getCovInformation(for: pickerSelection) { result in
            
            switch result {
                case .success(let covData):
                    print(covData)

                case .failure(let error):
                    print(error)
            }
        }
    }

}

extension MainVC: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return department.code.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let value = "\(department.code[row].index) - \(department.code[row].name)"
        return value
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerSelection = department.code[row].name
    }

}
