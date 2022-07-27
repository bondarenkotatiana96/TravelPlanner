//
//  YelpEvent.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/21/22.
//

import Foundation

struct Businesses: Decodable {
    let businesses: [Business]
}
struct Business: Decodable, Identifiable, Equatable {
    let id: String
    let name: String
    let url: String
    let image_url: String
}
