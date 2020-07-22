//
//  String+Ext.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 22/07/2020.
//

import Foundation

extension String {
    func convertToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self)!
    }
}
