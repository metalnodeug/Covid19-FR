//
//  CovData.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 17/07/2020.
//

import Foundation

// MARK: - CovData
struct CovData: Codable {
    let liveDataByDepartement: [LiveDataByDepartement]

    enum CodingKeys: String, CodingKey {
        case liveDataByDepartement = "LiveDataByDepartement"
    }
}

// MARK: - LiveDataByDepartement
struct LiveDataByDepartement: Codable {
    let code, nom, date: String
    let hospitalises, reanimation, nouvellesHospitalisations, nouvellesReanimations: Int
    let deces, gueris: Int
    let source: Source
    let sourceType: String
}

// MARK: - Source
struct Source: Codable {
    let nom: String
}
