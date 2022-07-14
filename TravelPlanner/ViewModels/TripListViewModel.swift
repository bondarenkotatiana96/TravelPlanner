//
//  TripViewModel.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/12/22.
//

import Foundation

class TripListViewModel: ObservableObject {
    
    @Published var trips: [Trip] = []
    
    // MARK: - CRUD Functions
    
    func createTrip(name: String) {
        let newTrip = Trip(name: name)
        trips.append(newTrip)
        // TODO: - Save to some kind of store or firebase?
    }
    
    func updateTrip(trip: Trip, name: String, dates: [Date], notes: String) {
        guard let index = trips.firstIndex(of: trip) else { return }
        // Update
        trips[index].name = name
        trips[index].dates = dates
        trips[index].notes = notes
        // TODO: - Save to some kind of store or firebase?
    }
    
    func deleteTrip(index: IndexSet) {
        trips.remove(atOffsets: index)
        // TODO: - Save to some kind of store or firebase?
    }
    
}
