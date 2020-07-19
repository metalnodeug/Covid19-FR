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
        if let data = covData.allDataByDepartement.last {
            if let hospitalises = data.hospitalises, let nouvellesHospitalisations = data.nouvellesHospitalisations, let reanimation = data.reanimation, let nouvellesReanimations = data.nouvellesReanimations {
                itemInfoViewOne.set(with: .hospitalized, withCount: hospitalises, delta: nouvellesHospitalisations)
                itemInfoViewTwo.set(with: .intensiveCare, withCount: reanimation, delta: nouvellesReanimations)
            }
        }
    }

}
