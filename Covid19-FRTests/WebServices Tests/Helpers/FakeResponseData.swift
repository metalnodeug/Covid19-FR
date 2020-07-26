//
//  FakeResponseData.swift
//  Covid19-FRTests
//
//  Created by MeTaLnOdEuG on 26/07/2020.
//

import Foundation

class FakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!

    static let responseKO = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

    class CovError: Error {}
    static let error = CovError()

    struct GetRequest {
        static var correctData: Data {
            let bundle = Bundle(for: FakeResponseData.self)
            let url = bundle.url(forResource: "GetCovDeptInformationRequest", withExtension: "json")
            let data = try! Data(contentsOf: url!)
            return data
        }
    }

    static let checkerFridgeIncorrectData = "erreur".data(using: .utf8)!
}
