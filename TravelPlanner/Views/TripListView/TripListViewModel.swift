//
//  TripViewModel.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/12/22.
//

import Foundation

class TripListViewModel: ObservableObject {
    
    @Published var trips: [Trip] = [
        Trip(name: "Moscow", dates: [Date(), Date()], notes: "", placesToVisit: [Place(name: "Bolshoy Theater"), Place(name: "Subway"), Place(name: "MSAL"), Place(name: "Red Square")], thingsToPack: [ThingToPack(name: "Passport", isPacked: false), ThingToPack(name: "Vaccination Card", isPacked: false), ThingToPack(name: "Warm Jacket", isPacked: false), ThingToPack(name: "Jeans", isPacked: false)]),
        Trip(name: "San Jose", dates: [Date(), Date()], notes: "Flight is at 3 pm. Don't forget to print boarding passes!", placesToVisit: [Place(name: "Bolshoy Theater"), Place(name: "Subway"), Place(name: "MSAL"), Place(name: "Red Square")], thingsToPack: [ThingToPack(name: "Passport", isPacked: false), ThingToPack(name: "Vaccination Card", isPacked: false), ThingToPack(name: "Warm Jacket", isPacked: false), ThingToPack(name: "Jeans", isPacked: false)])]
    
    // MARK: - CRUD Functions
    
    func createTrip(name: String) {
        let newTrip = Trip(name: name, notes: "", placesToVisit: [], thingsToPack: [])
        trips.append(newTrip)
        // TODO: - Save to some kind of store or firebase?
    }
    
    func updateTrip(trip: Trip, name: String, dates: [Date], notes: String, placesToVisit: [Place], thingsToPack: [ThingToPack]) {
        guard let index = trips.firstIndex(of: trip) else { return }
        // Update
        trips[index].name = trip.name
        trips[index].dates = trip.dates
        trips[index].notes = trip.notes
        trips[index].placesToVisit = trip.placesToVisit
        trips[index].thingsToPack = trip.thingsToPack
        // TODO: - Save to some kind of store or firebase?
    }
    
    func deleteTrip(index: IndexSet) {
        trips.remove(atOffsets: index)
        // TODO: - Save to some kind of store or firebase?
    }
    
}
