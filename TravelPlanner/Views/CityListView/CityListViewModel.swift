//
//  CityListViewModel.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/13/22.
//

import Foundation

class CityListViewModel: ObservableObject {
    
    @Published var cities: [CityViewModel] = []
    
    func search(name: String) {
            WebService().fetchCities(searchTerm: name) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let cities):
                        self.cities = cities.map(CityViewModel.init)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
    }
}

struct CityViewModel {
    
    let city: City
    
    var name: String {
        city.label
    }
    
    var id: String {
        city.id
    }
    
}
