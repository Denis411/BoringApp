//
//  BAError.swift
//  BoringApp
//
//  Created by Maxim Prosvirkin on 23.09.2021.
//

import Foundation

enum BAError: String, Error {
    case noActivity = "There is no activity. Please check your filter settings."
    case invalidRequest = "There is problem with request."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "Data received from the server was invalid. Please try again."
}
