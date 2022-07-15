//
//  BucketListViewModel.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/14/22.
//

import Foundation

class BucketListViewModel: ObservableObject {
    
    @Published var destinations: [BucketListDestination] = []
    
    // MARK: - CRUD Functions
    func createDestination(name: String) {
        let newDestination = BucketListDestination(name: name)
        destinations.append(newDestination)
    }
    
    func toggleIsVisited(_ destination: BucketListDestination) {
        guard let index = destinations.firstIndex(of: destination) else { return }
        destinations[index].isVisited.toggle()
    }
    
    func deleteDestination(index: IndexSet) {
        destinations.remove(atOffsets: index)
    }
}
