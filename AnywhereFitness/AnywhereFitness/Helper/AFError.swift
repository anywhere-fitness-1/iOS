//
//  AFError.swift
//  AnywhereFitness
//
//  Created by Norlan Tibanear on 8/31/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import Foundation


enum AFError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again"
    case unabletoComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this user. Please try again later."
    case alreadyInFavorites = "You already favorited this user. You must REALLY like them!"
}
