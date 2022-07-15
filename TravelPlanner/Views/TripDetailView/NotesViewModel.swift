//
//  NotesViewModel.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/14/22.
//

import Foundation


class NotesViewModel: ObservableObject {
    
    // MARK: - CRUD
    
    func updateNote(note: String, trip: Trip, tripListViewModel: TripListViewModel) {
      guard let index = tripListViewModel.trips.firstIndex(of: trip) else { return }
        tripListViewModel.trips[index].notes = note
    }
    
}
