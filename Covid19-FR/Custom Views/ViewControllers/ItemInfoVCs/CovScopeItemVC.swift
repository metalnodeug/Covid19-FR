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
        let lastValidValue = checkingDataDelta(for: covData)
        let delta = covData.allDataByDepartement[lastValidValue]

        if let hospitalises = data?.hospitalises, let reanimation = data?.reanimation, let deltaH = delta.hospitalises, let deltaR = delta.reanimation {
            itemInfoViewOne.set(with: .hospitalized, withCount: hospitalises , delta: deltaH)
            itemInfoViewTwo.set(with: .intensiveCare, withCount: reanimation , delta: deltaR)
        }
    }

    private func checkingDataDelta(for data: CovData) -> Int {
        let countAllData = data.allDataByDepartement.count
        var index: Int = countAllData - 1
        
        repeat {
            index -= 1
        } while data.allDataByDepartement[index].hospitalises == nil || data.allDataByDepartement[index].gueris == nil || data.allDataByDepartement[index].deces == nil || data.allDataByDepartement[index].reanimation == nil

        return index
    }

}
