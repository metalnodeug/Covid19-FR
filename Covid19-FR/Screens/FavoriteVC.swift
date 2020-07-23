//
//  FavoriteVC.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 21/07/2020.
//

import UIKit

class FavoriteVC: CovLoadingVC {

    let tableView = UITableView()
    var favorites: [FavData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
        configure_tableView()
    }

    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Favoris"
    }

    private func configure_tableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 70
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
        tableView.removedExcessCells()

        tableView.delegate = self
        tableView.dataSource = self
    }

    private func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }

            switch result {
                case .success(let favorites):
                    self.updateUI(with: favorites)
                case .failure(let error):
                    print(error)
            }
        }
    }

    private func updateUI(with favorites: [FavData]) {
        self.favorites = favorites
        DispatchQueue.main.async {

            if favorites.isEmpty {
                self.showEmptyStateView(with: "Veuillez ajouter un département aux favoris.", in: self.view)
            } else {
                self.view.bringSubviewToFront(self.tableView)
            }
            self.tableView.reloadData()
        }
    }

}

extension FavoriteVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = ShowingCovDataVC(department: favorite.name)
        navigationController?.pushViewController(destVC, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        let favorite = favorites[indexPath.row]

        PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                self.getFavorites()
                return
            }
            self.presentCovAlertOnMainThread(title: CovError.somethingWrong.rawValue, message: error.rawValue, buttonTitle: "Ok")
        }
    }
}
