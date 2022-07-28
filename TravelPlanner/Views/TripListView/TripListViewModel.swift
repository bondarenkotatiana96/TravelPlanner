//
//  TripViewModel.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/12/22.
//

import Foundation

class TripListViewModel: ObservableObject {
    
    @Published var trips: [Trip] = []
    
    let scheduler = NotificationScheduler()
    
    // MARK: - CRUD Functions
    
    func createTrip(name: String, latitude: Double, longitude: Double) {
        let newTrip = Trip(name: name, dates: [Date(), Date()], notes: "", placesToVisit: [], thingsToPack: [], latitude: latitude, longitude: longitude)
        trips.append(newTrip)
        saveToPersistenceStore()
        scheduler.scheduleUserNotification(for: newTrip)
    }
    
    func deleteTrip(index: IndexSet) {
        trips.remove(atOffsets: index)
        saveToPersistenceStore()
    }
    
    // MARK: - Persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Trip.json")
        return fileURL
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(trips)
            try data.write(to: createPersistenceStore())
        } catch {
            print("")
        }
    }
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            trips = try JSONDecoder().decode([Trip].self, from: data)
        } catch {
            print("")
        }
    }
}
