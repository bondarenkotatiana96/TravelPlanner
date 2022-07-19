//
//  PlaceToVisitViewModel.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/14/22.
//

import Foundation

class PlaceToVisitViewModel: ObservableObject {
    
    // MARK: - CRUD
    
    func createPlaceToVisit(name: String, latitude: Double, longitude: Double, trip: Trip, tripListViewModel: TripListViewModel) {
      guard let index = tripListViewModel.trips.firstIndex(of: trip) else { return }
        let newPlaceToVisit = Place(name: name, latitude: latitude, longitude: longitude)
        tripListViewModel.trips[index].placesToVisit.append(newPlaceToVisit)
    }

    func deletePlaceToVisit(trip: Trip, tripListViewModel: TripListViewModel, at indexSet: IndexSet) {
      guard let index = tripListViewModel.trips.firstIndex(of: trip) else { return }
        tripListViewModel.trips[index].placesToVisit.remove(atOffsets: indexSet)
    }
    
    func getLatitude(placeToVisit: Place, trip: Trip, tripListViewModel: TripListViewModel) -> Double {
        guard let indexTrip = tripListViewModel.trips.firstIndex(of: trip) else { return 0.0}
        guard let indexPlace = tripListViewModel.trips[indexTrip].placesToVisit.firstIndex(of: placeToVisit) else { return 0.0}
        let latitude = tripListViewModel.trips[indexTrip].placesToVisit[indexPlace].latitude
        return latitude
    }
    
    func getLongitude(placeToVisit: Place, trip: Trip, tripListViewModel: TripListViewModel) -> Double {
        guard let indexTrip = tripListViewModel.trips.firstIndex(of: trip) else { return 0.0}
        guard let indexPlace = tripListViewModel.trips[indexTrip].placesToVisit.firstIndex(of: placeToVisit) else { return 0.0}
        let longitude = tripListViewModel.trips[indexTrip].placesToVisit[indexPlace].latitude
        return longitude
    }
    
}
