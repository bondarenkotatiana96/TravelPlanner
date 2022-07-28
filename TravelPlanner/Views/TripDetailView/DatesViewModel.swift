//
//  DatesViewModel.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/14/22.
//

import Foundation

class DatesViewModel: ObservableObject {
    
    // MARK: - CRUD Functions
    
    func updateDate(dates: [Date], trip: Trip, tripListViewModel: TripListViewModel) {
        guard let index = tripListViewModel.trips.firstIndex(of: trip) else { return }
        tripListViewModel.trips[index].dates = dates
        tripListViewModel.saveToPersistenceStore()
    }
}
