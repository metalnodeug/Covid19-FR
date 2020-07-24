//
//  CovTabBarController.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 21/07/2020.
//

import UIKit

class CovTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemPink
        viewControllers = [
            createSearchNavigationController(),
            createFavoriteNavigationController(),
            createSettingsNavigationController()
        ]
    }

    private func createSearchNavigationController() -> UINavigationController {
        let mainVC = MainVC()
        mainVC.tabBarItem = .init(title: "Rechercher", image: SFSymbols.search, tag: 0)
        return UINavigationController(rootViewController:mainVC)
    }

    private func createFavoriteNavigationController() -> UINavigationController {
        let favoriteVC = FavoriteVC()
        favoriteVC.tabBarItem = .init(title: "Favoris", image: SFSymbols.favorites, tag: 1)
        return UINavigationController(rootViewController: favoriteVC)
    }

    private func createSettingsNavigationController() -> UINavigationController {
          let settingsVC = SettingsVC()
          settingsVC.tabBarItem = .init(title: "Réglages", image: SFSymbols.settings, tag: 2)
          return UINavigationController(rootViewController: settingsVC)
      }
}
