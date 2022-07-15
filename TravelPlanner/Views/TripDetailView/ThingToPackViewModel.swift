//
//  ThingToPackViewModel.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/14/22.
//

import Foundation

class ThingToPackViewModel: ObservableObject {
    
    // MARK: - CRUD
    
    func createThingToPack(thingToPack: ThingToPack, trip: Trip, tripListViewModel: TripListViewModel) {
      guard let index = tripListViewModel.trips.firstIndex(of: trip) else { return }
        tripListViewModel.trips[index].thingsToPack.append(thingToPack)
    }
    
    func toggleIsPacked(thingToPack: ThingToPack, trip: Trip, tripListViewModel: TripListViewModel) {
        guard let indexTrip = tripListViewModel.trips.firstIndex(of: trip) else { return }
        guard let indexThing = tripListViewModel.trips[indexTrip].thingsToPack.firstIndex(of: thingToPack) else { return }
        tripListViewModel.trips[indexTrip].thingsToPack[indexThing].isPacked.toggle()
    }

    func deleteThingToPack(trip: Trip, tripListViewModel: TripListViewModel, at indexSet: IndexSet) {
      guard let index = tripListViewModel.trips.firstIndex(of: trip) else { return }
        tripListViewModel.trips[index].thingsToPack.remove(atOffsets: indexSet)
    }
    
}
