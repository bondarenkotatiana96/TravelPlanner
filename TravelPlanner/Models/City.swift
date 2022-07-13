//
//  City.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/13/22.
//

import Foundation

struct TopLevelObject: Decodable {
    let response: SecondLevelObject
}

struct SecondLevelObject: Decodable {
    let features: [ThirdLevelObject]
}

struct ThirdLevelObject: Decodable {
    let properties: City
}

struct City: Decodable {
    let label: String
    let id: String
}
