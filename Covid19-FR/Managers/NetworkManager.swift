//
//  NetworkManager.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 17/07/2020.
//

import Foundation
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://coronavirusapi-france.now.sh/LiveDataByDepartement?Departement="

    private init () {}

    func getCovDeptInformation(for department: String, completion: @escaping (Result<CovData, CovError>) -> Void) {
        let endpoint = baseURL + "\(department)"
        let convertedEndpoint = endpoint.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!
        print(endpoint)
        guard let url = URL(string: convertedEndpoint) else {
            completion(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidData))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let covData = try decoder.decode(CovData.self, from: data)
                completion(.success(covData))
            } catch {
                completion(.failure(.invalidData))
            }
        }

        task.resume()
    }
}

