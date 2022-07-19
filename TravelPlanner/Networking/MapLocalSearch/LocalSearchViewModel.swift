//
//  LocalSearchViewModel.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/19/22.
//

import Foundation
import MapKit
import Combine

final class LocalSearchViewModel: ObservableObject {
    private var cancellable: AnyCancellable?
    
    @Published var poiText = "" {
        didSet {
            searchForPOI(text: poiText)
        }
    }
    
    @Published var viewData = [LocalSearchData]()

    var service: LocalSearchService
    
    init() {
//        New York
        let center = CLLocationCoordinate2D(latitude: 40.730610, longitude: -73.935242)
        service = LocalSearchService(in: center)
        
        cancellable = service.localSearchPublisher.sink { mapItems in
            self.viewData = mapItems.map({ LocalSearchData(mapItem: $0) })
        }
    }
    
    private func searchForPOI(text: String) {
        service.searchPointOfInterests(searchText: text)
    }
}
