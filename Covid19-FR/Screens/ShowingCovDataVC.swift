//
//  ShowingCovDataVC.swift
//  Covid19-FR
//
//  Created by metalnodeug on 18/07/2020.
//

import UIKit

class ShowingCovDataVC: UIViewController {
    var department: String!

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

    private func getCovData(for department: String) {
        NetworkManager.shared.getCovInformation(for: department) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let covData):
                print(covData)

            case .failure(let error):
                print(error)
            }
        }
    }
}
