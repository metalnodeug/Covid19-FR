//
//  MainVC.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 17/07/2020.
//

import UIKit
import Foundation

class MainVC: UIViewController {

    let logoImageView = UIImageView()
    let textLabel = UILabel()
    let entryTextField = UITextField()
    let entryPickerView = UIPickerView()
    let actionButton = CovButton(type: .system)

    let department = Department()
    var pickerSelection: String = "Bas-Rhin"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Rechercher"
        navigationController?.setNavigationBarHidden(true, animated: true)
        logoImageView.rotate()
    }

    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(enterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
    }

    @objc func enterForeground() {
        logoImageView.rotate()
    }

    private func configureUI() {
        configure_logoImageView()
        configure_textLabel()
        configure_entryTextField()
        configure_actionButton()
    }

    private func configure_logoImageView() {
        view.addSubview(logoImageView)
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = UIImage(named: "CovidLogo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 190),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor)
        ])
    }

    private func configure_textLabel() {
        view.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textAlignment = .center
        textLabel.text = "Selectionner un département:"
        textLabel.numberOfLines = 2
        textLabel.font = UIFont.boldSystemFont(ofSize: 17)

        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.heightAnchor.constraint(equalToConstant: 20),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }

    private func configure_entryTextField() {
        view.addSubview(entryTextField)
        entryTextField.translatesAutoresizingMaskIntoConstraints = false
        entryTextField.text = "67 - Bas-Rhin"
        entryTextField.backgroundColor = .secondarySystemBackground
        entryTextField.textAlignment = .center
        entryTextField.layer.borderWidth = 2
        entryTextField.layer.borderColor = UIColor.systemBackground.cgColor
        entryTextField.layer.cornerRadius = 10
        entryTextField.inputView = entryPickerView
        createToolBar()

        entryPickerView.delegate = self
        entryPickerView.dataSource = self
        entryPickerView.selectRow(67, inComponent: 0, animated: false)

        NSLayoutConstraint.activate([
            entryTextField.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 15),
            entryTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            entryTextField.heightAnchor.constraint(equalToConstant: 50),
            entryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            entryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
    }

    private func createToolBar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Valider", style: .plain, target: self, action: #selector(dismissPickerView))

        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true

        entryTextField.inputAccessoryView = toolbar
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.view {
            view.endEditing(true)
        }
    }

    @objc private func dismissPickerView() {
        view.endEditing(true)
    }

    private func configure_actionButton() {
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false

        actionButton.set(title:"Afficher")
        actionButton.addTarget(self, action: #selector(searchAction), for: .touchUpInside)

        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: entryTextField.bottomAnchor, constant: 30),
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
        ])
    }

    @objc private func searchAction() {
        view.endEditing(true)
        navigationController?.pushViewController(ShowingCovDataVC(department: pickerSelection), animated: true)
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
        entryTextField.text = "\(department.code[row].index) - \(department.code[row].name)"
    }

}
