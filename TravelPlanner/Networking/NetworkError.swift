//
//  NetworkError.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/20/22.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badResponse
    case noData
    case thrownError(Error)
    case unableToDecode(Error?)
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Unable to reach the server. Invalid URL"
        case .thrownError(let error):
            return error.localizedDescription
        case .badResponse:
            return "The server sent back a bad response."
        case .noData:
            return "The server did not send back any data."
        case .unableToDecode(let error):
            if let error = error {
                return error.localizedDescription
            } else {
                return "Unable to decode"
            }
        }
    }
}
