//
//  PersistenceManager.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 21/07/2020.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard

    enum Keys {
        static let favorites = "favorites"
    }

    static func updateWith(favorite: FavData, actionType: PersistenceActionType, completed: @escaping (CovError?) -> Void ) {
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):

                switch actionType {
                case .add:
                    favorites.append(favorite)
                case .remove:
                    favorites.removeAll { $0.code == favorite.code }
                }

                completed(save(favorites: favorites))

            case .failure(let error):
                completed(error)
            }
        }
    }

    static func retrieveFavorites(completed: @escaping (Result<[FavData], CovError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }

        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([FavData].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }

    static func save(favorites: [FavData]) -> CovError? {

        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
