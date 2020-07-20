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
        let lastValidValue = checkingDataDelta(for: covData)
        let delta = covData.allDataByDepartement[lastValidValue]

        if let deces = data?.deces, let gueris = data?.gueris, let deltaD = delta.deces, let deltaG = delta.gueris {
            itemInfoViewOne.set(with: .death, withCount: deces , delta: deltaD)
            itemInfoViewTwo.set(with: .healed, withCount: gueris , delta: deltaG)
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
