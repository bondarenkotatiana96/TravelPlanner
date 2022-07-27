//
//  TopLocation.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/21/22.
//

import Foundation

struct Results: Decodable {
    let results: [TopLocation]
}

struct TopLocation: Decodable, Identifiable, Equatable {
    let id: String
    let name: String
    let snippet: String
}
