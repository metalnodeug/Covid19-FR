//
//  ShowingCovDataVC.swift
//  Covid19-FR
//
//  Created by metalnodeug on 18/07/2020.
//

import UIKit

class ShowingCovDataVC: CovLoadingVC {
    var department: String!

    let labelItemViewOne = CovSubtitleLabel()
    let itemViewOne = UIView()
    let labelItemViewTwo = CovSubtitleLabel()
    let itemViewTwo = UIView()
    let dateLabel = CovDateLabel()

    var itemViews: [UIView] = []
    var isFavorite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        retrieveFavValue()
        configure_navigationController()
        title = department
        layoutUI()
        getCovData(for: department)
    }
    
    init(department: String) {
        super.init(nibName: nil, bundle: nil)
        self.department = department
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure_navigationController() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true

        let addFavoriteButton = UIBarButtonItem(image: configureFavoriteButtonImage(), style: .plain, target: self, action: #selector(favButtonAction))
        navigationItem.rightBarButtonItem = addFavoriteButton
    }

    @objc private func favButtonAction() {
        let favorite = FavData(code: retrieveDepartmentCode(), name: department )

        if !isFavorite {
            PersistenceManager.updateWith(favorite: favorite, actionType: .add) { error in
                self.isFavorite = true
                self.navigationItem.rightBarButtonItem?.image = self.configureFavoriteButtonImage()
                print("I have saved")
            }
        } else {
            PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { error in
                print("I have delete")
                self.isFavorite = false
                self.navigationItem.rightBarButtonItem?.image = self.configureFavoriteButtonImage()
            }
        }
    }

    private func retrieveFavValue() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }

            switch result {
                case .success(let data):
                    print(data)
                    for value in data {
                        if value.name.contains(self.department) {
                            self.isFavorite = true
                        }
                    }

                case .failure(let error):
                    print(error)
            }
        }
    }

    private func retrieveDepartmentCode() -> String {
        let array = Department()
        var departmentCode = ""

        for (code, name) in array.code {
            if name == department {
                departmentCode = code
            }
        }

        return departmentCode
    }

    private func configureFavoriteButtonImage() -> UIImage {
        if isFavorite {
            return UIImage(systemName: "heart.fill")!
        } else {
            return UIImage(systemName: "heart")!
        }
    }
    
    private func getCovData(for department: String) {
        showLoadingView()
        
        NetworkManager.shared.getCovDeptInformation(for: department) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
                case .success(let covData):
                    self.updateUI(with: covData)
                    
                case .failure(let error):
                    self.presentCovAlertOnMainThread(title: CovError.somethingWrong.rawValue, message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }

    private func layoutUI() {
        let padding: CGFloat = 20
        let paddingLabel: CGFloat = 15
        let itemHeight: CGFloat = 95

        itemViews = [itemViewOne, itemViewTwo, dateLabel, labelItemViewOne, labelItemViewTwo]

        for item in itemViews {
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            labelItemViewOne.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            labelItemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            labelItemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),

            itemViewOne.topAnchor.constraint(equalTo: labelItemViewOne.bottomAnchor, constant: paddingLabel),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

            labelItemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            labelItemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            labelItemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),

            itemViewTwo.topAnchor.constraint(equalTo: labelItemViewTwo.bottomAnchor, constant: paddingLabel),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),

            dateLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: padding*2)
        ])
    }

    private func configure_UIElements(with covData: CovData) {
        self.add(childVC: CovGlobalItemVC(covData: covData), to: self.itemViewOne)
        self.add(childVC: CovScopeItemVC(covData: covData), to: self.itemViewTwo)

        self.labelItemViewOne.text = "Données depuis le début de l'épidémie :"
        self.labelItemViewTwo.text = "Evolution sur les dernières 24H :"

        self.dateLabel.text = "Données au : " + String(covData.allDataByDepartement.last?.date ?? "??") + "\n Santé Publique France "
    }
    
    private func updateUI(with covData: CovData) {
        if covData.allDataByDepartement.count == 0 {
            presentCovAlertOnMainThread(title: "Erreur", message: "Une erreur est survenue lors de la récupération des données. Il est possible que les données ne soient pas encore mises à jour. Merci de rééssayer ultérieurement.", buttonTitle: "Ok")
        } else {
            DispatchQueue.main.async {
                self.configure_UIElements(with: covData)
            }
        }
    }

    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}
