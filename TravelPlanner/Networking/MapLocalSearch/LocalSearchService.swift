//
//  LocalSearchService.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/19/22.
//

import Combine
import MapKit

final class LocalSearchService {
    let localSearchPublisher = PassthroughSubject<[MKMapItem], Never>()
    
    public func searchPointOfInterests(searchText: String) {
        request(searchText: searchText)
    }
    
    private func request(resultType: MKLocalSearch.ResultType = .pointOfInterest,
                         searchText: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.pointOfInterestFilter = .includingAll
        request.resultTypes = resultType
        let search = MKLocalSearch(request: request)

        search.start { [weak self](response, _) in
            guard let response = response else { return }
            self?.localSearchPublisher.send(response.mapItems)
        }
    }
}
