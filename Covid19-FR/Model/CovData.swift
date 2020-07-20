//
//  CovData.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 17/07/2020.
//

import Foundation

// MARK: - CovData
struct CovData: Codable {
    let allDataByDepartement: [AllDataByDepartement]
}

// MARK: - AllDataByDepartement
struct AllDataByDepartement: Codable {
    let date: String
    let hospitalises, reanimation, gueris, deces : Int?
}
