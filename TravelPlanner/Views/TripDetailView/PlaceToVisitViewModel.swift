//
//  PlaceToVisitViewModel.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/14/22.
//

import Foundation

class PlaceToVisitViewModel: ObservableObject {
    
    // MARK: - CRUD
    
    func createPlaceToVisit(placeToVisit: Place, trip: Trip, tripListViewModel: TripListViewModel) {
      guard let index = tripListViewModel.trips.firstIndex(of: trip) else { return }
        tripListViewModel.trips[index].placesToVisit.append(placeToVisit)
    }

    func deletePlaceToVisit(trip: Trip, tripListViewModel: TripListViewModel, at indexSet: IndexSet) {
      guard let index = tripListViewModel.trips.firstIndex(of: trip) else { return }
        tripListViewModel.trips[index].placesToVisit.remove(atOffsets: indexSet)
    }
    
}
