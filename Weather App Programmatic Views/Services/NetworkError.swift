//
//  NetworkError.swift
//  Weather App
//
//  Created by Kuda Zata on 30/11/2022.
//

import Foundation

/// The different error types that might occur when making network calls
enum NetworkError: Error {
    case badUrl
    case decodingError
    case badRequest
    case noData
    case customError(Error)
    
    var message: String {
        switch self {
        case .badUrl:
            return "There was an error connecting to the server. Please try again"
        case .decodingError:
            return "There was an error connecting to the server. Please try again"
        case .badRequest:
            return "There was an error connecting to the server. Please try again"
        case .noData:
            return "There was an error connecting to the server. Please try again"
        case .customError(let error):
            return error.localizedDescription
        }
    }
}

