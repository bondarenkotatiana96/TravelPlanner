//
//  Trip.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/12/22.
//

import Foundation

struct Trip: Equatable, Identifiable {
    var name: String
    var dates: [Date]
    var notes: String
    var placesToVisit: [Place] //  I will probably need a model for a place to visit because I am getting this from an API
    var thingsToPack: [ThingToPack]
    var id = UUID()
    var latitude: Double
    var longitude: Double
}
