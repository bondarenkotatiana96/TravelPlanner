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
        saveToPersistenceStore()
    }
    
    func toggleIsVisited(_ destination: BucketListDestination) {
        guard let index = destinations.firstIndex(of: destination) else { return }
        destinations[index].isVisited.toggle()
        saveToPersistenceStore()
    }
    
    func deleteDestination(index: IndexSet) {
        destinations.remove(atOffsets: index)
        saveToPersistenceStore() 
    }
    
    // MARK: - Persistence
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("BucketList.json")
        return fileURL
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(destinations)
            try data.write(to: createPersistenceStore())
        } catch {
            print("")
        }
    }
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            destinations = try JSONDecoder().decode([BucketListDestination].self, from: data)
        } catch {
            print("")
        }
    }
}
