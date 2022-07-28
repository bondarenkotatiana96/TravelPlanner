//
//  YelpService.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/21/22.
//

import Foundation

class YelpService {
    func fetchYelpData(latitude: Double, longitude: Double, completion: @escaping (Result<[Business], NetworkError>) -> Void) {

        guard let apiKey = Bundle.main.infoDictionary?["YELP_API_KEY"] as? String else { return completion(.failure(.badURL))}
        
        guard let baseURL = URL(string: "https://api.yelp.com/v3/businesses/search?latitude=\(latitude)&longitude=\(longitude)&categories=amusementparks,beaches,boating,bungeejumping,diving,experiences,flyboarding,gliding,hiking,lakes,skydiving,surfing,hotelstravel,festivals,galleries&limit=20") else { return completion(.failure(.badURL))}
        
        var request = URLRequest(url: baseURL)
        request.allHTTPHeaderFields = ["Authorization": "Bearer " + apiKey]
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            do {
                let businesses = try JSONDecoder().decode(Businesses.self, from: data)
                let topBusinesses = businesses.businesses
                return completion(.success(topBusinesses))
            } catch {
                return completion(.failure(.unableToDecode(error)))
            }
        }.resume()
    }
}
