//
//  WebService.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/13/22.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badResponse
    case noData
    case trownError
    case unableToDecode
}

class WebService {
    
    func fetchCities(searchTerm: String, completion: @escaping (Result<[City], NetworkError>) -> Void) {
        
        guard let baseURL = URL(string: "https://api.geocodify.com/v2/autocomplete") else { return completion(.failure(.badURL))}
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: "409d4fcfaaeebd8287c435fe52ddbbf5b27f13f7"),
            URLQueryItem(name: "q", value: searchTerm)
        ]
        
        guard let finalURL = components?.url else { return completion(.failure(.badURL))}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                completion(.failure(.trownError))
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let secondLevelObject = topLevelObject.response
                let thirdLevelObject = secondLevelObject.features
                
                var arrayOfCities: [City] = []
                
                for dictionary in thirdLevelObject {
                    let city = dictionary.properties
                    arrayOfCities.append(city)
                }
                return completion(.success(arrayOfCities))
            } catch {
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    func getCoordinates(location: String, completion: @escaping (Result<[Double], NetworkError>) -> Void) {
        
        guard let baseURL = URL(string: "https://api.geocodify.com/v2/geocode") else { return completion(.failure(.badURL))}
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [
            URLQueryItem(name: "api_key", value: "409d4fcfaaeebd8287c435fe52ddbbf5b27f13f7"),
            URLQueryItem(name: "q", value: location)
        ]
        
        guard let finalURL = components?.url else { return completion(.failure(.badURL))}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                completion(.failure(.trownError))
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            print(data)
            do {
                let topLevel = try JSONDecoder().decode(TopLevel.self, from: data)
                let secondLevel = topLevel.response
                let thirdLevel = secondLevel.features
                let coordinates = thirdLevel[0].geometry
                let cityCoordinates = coordinates.coordinates
                return completion(.success(cityCoordinates))
            } catch {
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    }
}
