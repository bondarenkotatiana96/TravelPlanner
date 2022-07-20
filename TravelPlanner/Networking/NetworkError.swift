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
    case thrownError
    case unableToDecode
}
