//
//  DataHelper.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 20/07/2020.
//

import Foundation

struct DataHelper {

    static func checkingDataDelta(for data: CovData) -> Int {
        let countAllData = data.allDataByDepartement.count
        var index: Int = countAllData - 1

        repeat {
            index -= 1
        } while data.allDataByDepartement[index].hospitalises == nil || data.allDataByDepartement[index].gueris == nil || data.allDataByDepartement[index].deces == nil || data.allDataByDepartement[index].reanimation == nil

        return index
    }

}
