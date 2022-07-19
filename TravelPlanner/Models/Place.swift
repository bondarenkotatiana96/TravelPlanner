//
//  Place.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/12/22.
//

import Foundation

struct Place: Equatable, Identifiable {
    var name: String
    var id = UUID()
    let latitude: Double
    let longitude: Double
}
