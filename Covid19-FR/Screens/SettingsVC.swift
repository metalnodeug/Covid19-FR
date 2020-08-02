//
//  SettingsVC.swift
//  Covid19-FR
//
//  Created by metalnodeug on 24/07/2020.
//

import UIKit

class SettingsVC: UIViewController {
    
    let versionLabel = UILabel()
    let settingsTableView = UITableView()
    let settingsCells: [CellType] = [.purchase,.restore]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configure_UI()
        
        IAPService.shared.delegate = self
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Réglages"
    }
    
    private func configure_UI() {
        configure_versionLabel()
        configure_settingsTableView()
    }
    
    private func configure_versionLabel() {
        view.addSubview(versionLabel)
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        versionLabel.text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        versionLabel.textColor = .secondaryLabel
        versionLabel.font = UIFont.boldSystemFont(ofSize: 14)
        versionLabel.textAlignment = .right
        
        let padding: CGFloat = 15
        
        NSLayoutConstraint.activate([
            versionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            versionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            versionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            versionLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configure_settingsTableView() {
        view.addSubview(settingsTableView)
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        settingsTableView.frame = view.bounds
        settingsTableView.rowHeight = 50
        settingsTableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseID)
        settingsTableView.removedExcessCells()
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        
        let padding: CGFloat = 15
        
        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            settingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            settingsTableView.bottomAnchor.constraint(equalTo: versionLabel.topAnchor)
        ])
    }
}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseID, for: indexPath) as! SettingsCell
        cell.set(cellType: settingsCells[indexPath.row])
        cell.selectionStyle  = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selection = indexPath.row
        if selection == 0 {
            let destVC = PurchaseVC()
            navigationController?.pushViewController(destVC, animated: true)
        } else {
            IAPService.shared.restorePurchases()
        }
    }
}

extension SettingsVC: IAPServiceDelegate {
    func didFinishRestored() {
        presentCovAlertOnMainThread(title: "Achat restauré", message: "Les achats ont été restaurés avec succès", buttonTitle: "Ok")
    }
}
