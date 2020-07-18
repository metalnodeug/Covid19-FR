//
//  ShowingCovDataVC.swift
//  Covid19-FR
//
//  Created by metalnodeug on 18/07/2020.
//

import UIKit

class ShowingCovDataVC: CovLoadingVC {
    var department: String!
    let dateUpdate = UILabel()
    let containerView = CovItemInfoView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(false, animated: true)
        configureUI()
        getCovData(for: department)
    }

    init(department: String) {
        super.init(nibName: nil, bundle: nil)
        self.department = department
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = department
        configure_dateUpdate()
        configure_containerView()
    }

    private func configure_dateUpdate() {
        view.addSubview(dateUpdate)
        dateUpdate.translatesAutoresizingMaskIntoConstraints = false
        dateUpdate.textAlignment = .center
        dateUpdate.textColor = .secondaryLabel
        dateUpdate.font = UIFont.boldSystemFont(ofSize: 14)

        NSLayoutConstraint.activate([
            dateUpdate.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            dateUpdate.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dateUpdate.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dateUpdate.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    private func configure_containerView() {
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .secondarySystemBackground
        containerView.layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            containerView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func getCovData(for department: String) {
        showLoadingView()

        NetworkManager.shared.getCovDeptInformation(for: department) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()

            switch result {
            case .success(let covData):
                print(covData)
                self.updateUI(with: covData)

            case .failure(let error):
                print(error)
            }
        }
    }

    private func updateUI(with covData: CovData) {
        DispatchQueue.main.async {
            self.dateUpdate.text = "Dernière mise à jour le: " + covData.liveDataByDepartement[0].date
            self.containerView.set(itemInfoType: .global, withCount: covData.liveDataByDepartement[0].deces, secondElementCount: covData.liveDataByDepartement[0].gueris)
        }
    }
}
