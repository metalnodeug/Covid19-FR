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
    let secondary_containerView = CovItemInfoView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = department
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
        configure_dateUpdate()
        configure_containerView()
        configure_secondary_containerView()
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

    private func configure_secondary_containerView() {
        view.addSubview(secondary_containerView)
        secondary_containerView.translatesAutoresizingMaskIntoConstraints = false
        secondary_containerView.backgroundColor = .secondarySystemBackground
        secondary_containerView.layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            secondary_containerView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20),
            secondary_containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            secondary_containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            secondary_containerView.heightAnchor.constraint(equalToConstant: 100)
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
        if covData.liveDataByDepartement.count == 0 {
            DispatchQueue.main.async {
                let alertVC = UIAlertController(title: "Erreur", message: "Une erreur est survenue lors de la récupération des données. Il est possible que les données ne soient pas encore mises à jour. Merci de rééssayer ultérieurement.", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { _ in
                    self.navigationController?.popViewController(animated: true)
                }
                alertVC.modalPresentationStyle = .overFullScreen
                alertVC.modalTransitionStyle = .crossDissolve
                alertVC.addAction(OKAction)
                self.present(alertVC, animated: true)
            }
        } else {
            DispatchQueue.main.async {
                let death = covData.liveDataByDepartement[0].deces
                let hospitalising = covData.liveDataByDepartement[0].hospitalises
                let heeris = covData.liveDataByDepartement[0].gueris
                let reanimation = covData.liveDataByDepartement[0].reanimation
                let newReanimation = covData.liveDataByDepartement[0].nouvellesReanimations
                let newHospitalising = covData.liveDataByDepartement[0].nouvellesHospitalisations

                self.dateUpdate.text = "Dernière mise à jour le: " + covData.liveDataByDepartement[0].date
                self.containerView.set(with: .global, withCount: death, firstDelta: nil, secondCount: heeris, secondDelta: nil)
                self.secondary_containerView.set(with: .scope, withCount: hospitalising, firstDelta: newHospitalising, secondCount: reanimation, secondDelta: newReanimation)
                self.configureUI()
            }
        }
    }
}
