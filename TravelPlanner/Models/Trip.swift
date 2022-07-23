//
//  Trip.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/12/22.
//

import Foundation

struct Trip: Equatable, Identifiable, Codable {
    var name: String
    var dates: [Date]
    var notes: String
    var placesToVisit: [Place]
    var thingsToPack: [ThingToPack]
    var id = UUID()
    let latitude: Double
    let longitude: Double
}
