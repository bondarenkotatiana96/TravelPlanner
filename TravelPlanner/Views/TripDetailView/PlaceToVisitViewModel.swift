//
//  PlaceToVisitViewModel.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/14/22.
//

import Foundation

class PlaceToVisitViewModel: ObservableObject {
    
    // MARK: - CRUD Functions
    
    func createPlaceToVisit(name: String, latitude: Double, longitude: Double, trip: Trip, tripListViewModel: TripListViewModel) {
        guard let index = tripListViewModel.trips.firstIndex(of: trip) else { return }
        let newPlaceToVisit = Place(name: name, latitude: latitude, longitude: longitude)
        tripListViewModel.trips[index].placesToVisit.append(newPlaceToVisit)
        tripListViewModel.saveToPersistenceStore()
    }

    func deletePlaceToVisit(trip: Trip, tripListViewModel: TripListViewModel, at indexSet: IndexSet) {
        guard let index = tripListViewModel.trips.firstIndex(of: trip) else { return }
        tripListViewModel.trips[index].placesToVisit.remove(atOffsets: indexSet)
        tripListViewModel.saveToPersistenceStore()
    }
}
