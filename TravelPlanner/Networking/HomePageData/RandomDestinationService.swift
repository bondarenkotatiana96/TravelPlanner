//
//  RandomDestinationService.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/20/22.
//

import Foundation

class RandomDestinationService {
    func getRandomDestination(completion: @escaping (Result<RandomDestination, NetworkError>) -> Void) {
        
        guard let baseURL = URL(string: "https://random-data-api.com/api/address/random_address") else { return completion(.failure(.badURL))}
        
        print(baseURL)
        
        URLSession.shared.dataTask(with: baseURL) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError))
                print(error.localizedDescription)
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            print(data)
            do {
                let randomDestination = try JSONDecoder().decode(RandomDestination.self, from: data)
                return completion(.success(randomDestination))
            } catch {
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    }
}
