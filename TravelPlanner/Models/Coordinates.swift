//
//  Coordinates.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/18/22.
//

import Foundation

import Foundation

struct TopLevel: Decodable {
    let response: SecondLevel
}

struct SecondLevel: Decodable {
    let features: [ThirdLevel]
}

struct ThirdLevel: Decodable {
    let geometry: Coordinates
}

struct Coordinates: Decodable {
    let coordinates: [Double]
}
