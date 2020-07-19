//
//  CovGlobalItemVC.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 19/07/2020.
//

import UIKit

class CovGlobalItemVC: CovItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    override init(covData: CovData) {
        super.init(covData: covData)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureItems() {
        if let data = covData.allDataByDepartement.last {
            if let deces = data.deces, let gueris = data.gueris {
                itemInfoViewOne.set(with: .death, withCount: deces)
                itemInfoViewTwo.set(with: .healed, withCount: gueris)
            }
        }
    }

}
