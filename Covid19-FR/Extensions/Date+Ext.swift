//
//  Date+Ext.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 22/07/2020.
//

import Foundation

extension Date {
    func convertToDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: self)
    }
}
