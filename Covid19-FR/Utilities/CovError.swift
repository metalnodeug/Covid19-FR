//
//  CovError.swift
//  Covid19-FR
//
//  Created by MeTaLnOdEuG on 17/07/2020.
//

import Foundation

enum CovError: String, Error {
    case invalidURL = "Invalid URL."
    case unableToComplete = "Unable to complete your request. Please chech your internet connection."
    case invalidResponse = "Invalid response from server. Please try again."
    case invalidData = "The data receive from the server is invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this user. Please try again"
    case alreadyInFavorite = "This user is already in favorite, you can't add this user too"
    case somethingWrong = "Something went wrong."
}

