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
        let data = covData.allDataByDepartement.last
        let lastValidValue = DataHelper.checkingDataDelta(for: covData)
        let delta = covData.allDataByDepartement[lastValidValue]

        if let deces = data?.deces, let gueris = data?.gueris, let deltaD = delta.deces, let deltaG = delta.gueris {
            itemInfoViewOne.set(with: .death, withCount: deces , delta: deltaD)
            itemInfoViewTwo.set(with: .healed, withCount: gueris , delta: deltaG)
        }
    }

}
