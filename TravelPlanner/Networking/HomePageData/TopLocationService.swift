//
//  TopLocationService.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/21/22.
//

import Foundation

class TopLocationService {
    func getTopLocations(completion: @escaping (Result<[TopLocation], NetworkError>) -> Void) {
        
        guard let baseURL = URL(string: "https://www.triposo.com/api/20220705/location.json?part_of=United_States&tag_labels=city&count=10&fields=id,name,score,snippet&order_by=-score") else { return completion(.failure(.badURL))}
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [
            URLQueryItem(name: "account", value: "6DL4LL05"),
            URLQueryItem(name: "token", value: "4b1r6aye4y55r3nokqsywbue7mbklr32")
        ]
        
        guard let finalURL = components?.url else { return completion(.failure(.badURL))}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError))
                print(error.localizedDescription)
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            print(data)
            do {
                let results = try JSONDecoder().decode(Results.self, from: data)
                let topLocations = results.results
                return completion(.success(topLocations))
            } catch {
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    }
}
