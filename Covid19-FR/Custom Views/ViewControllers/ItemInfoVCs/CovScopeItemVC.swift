//
//  CovScopeItemVC.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 19/07/2020.
//

import UIKit

class CovScopeItemVC: CovItemInfoVC {

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

        if let hospitalises = data?.hospitalises, let reanimation = data?.reanimation, let deltaH = delta.hospitalises, let deltaR = delta.reanimation {
            itemInfoViewOne.set(with: .hospitalized, withCount: hospitalises , delta: deltaH)
            itemInfoViewTwo.set(with: .intensiveCare, withCount: reanimation , delta: deltaR)
        }
    }

}
