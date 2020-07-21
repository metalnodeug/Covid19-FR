//
//  FavoriteVC.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 21/07/2020.
//

import UIKit

class FavoriteVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

}
