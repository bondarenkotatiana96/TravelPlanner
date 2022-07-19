//
//  TripViewModel.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/12/22.
//

import Foundation

class TripListViewModel: ObservableObject {
    
    @Published var trips: [Trip] = [
        Trip(name: "Moscow", dates: [Date(), Date()], notes: "", placesToVisit: [Place(name: "Bolshoy Theater", latitude: 55.741469, longitude: 37.615561), Place(name: "Subway", latitude: 55.741469, longitude: 37.615561), Place(name: "MSAL", latitude: 55.741469, longitude: 37.615561), Place(name: "Red Square", latitude: 55.741469, longitude: 37.615561)], thingsToPack: [ThingToPack(name: "Passport", isPacked: false), ThingToPack(name: "Vaccination Card", isPacked: false), ThingToPack(name: "Warm Jacket", isPacked: false), ThingToPack(name: "Jeans", isPacked: false)], latitude: 55.741469, longitude: 37.615561),
        Trip(name: "San Jose", dates: [Date(), Date()], notes: "Flight is at 3 pm. Don't forget to print boarding passes!", placesToVisit: [Place(name: "Bolshoy Theater", latitude: 55.741469, longitude: 37.615561), Place(name: "Subway", latitude: 55.741469, longitude: 37.615561), Place(name: "MSAL", latitude: 55.741469, longitude: 37.615561), Place(name: "Red Square", latitude: 55.741469, longitude: 37.615561)], thingsToPack: [ThingToPack(name: "Passport", isPacked: false), ThingToPack(name: "Vaccination Card", isPacked: false), ThingToPack(name: "Warm Jacket", isPacked: false), ThingToPack(name: "Jeans", isPacked: false)], latitude: 55.741469, longitude: 37.615561)]
    
    // MARK: - CRUD Functions
    
    func createTrip(name: String, latitude: Double, longitude: Double) {
        let newTrip = Trip(name: name, dates: [Date(), Date()], notes: "", placesToVisit: [], thingsToPack: [], latitude: latitude, longitude: longitude)
        trips.append(newTrip)
        // TODO: - Save to some kind of store or firebase?
    }
    
    func deleteTrip(index: IndexSet) {
        trips.remove(atOffsets: index)
        // TODO: - Save to some kind of store or firebase?
    }
    
}
