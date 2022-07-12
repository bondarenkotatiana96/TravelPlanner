//
//  TripViewModel.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/12/22.
//

import Foundation

class TripListViewModel: ObservableObject {
    
    @Published var trips: [Trip] = [Trip(name: "Moscow", dates: [Date(), Date()], notes: "Flight is at 3 pm. Don't forget to print boarding passes!", placesToVisit: ["Bolshoy Theater", "Subway", "MSAL", "Red Square"], thingsToPack: ["Passport", "Vaccination Card", "Warm jacket", "Jeans"]), Trip(name: "Berlin", dates: [Date(), Date()], notes: "Flight is at 3 pm. Don't forget to print boarding passes!", placesToVisit: ["Bolshoy Theater", "Subway", "MSAL", "Red Square"], thingsToPack: ["Passport", "Vaccination Card", "Warm jacket", "Jeans"])]
    
    // MARK: - CRUD Functions
    
    func createTrip(name: String, dates: [Date], notes: String, plasesToVisit: [String], thingsToPack: [String]) {
        let newTrip = Trip(name: name, dates: [], notes: notes, placesToVisit: [], thingsToPack: [])
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
