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
struct Business: Decodable, Identifiable {
    let id: String
    let name: String
    let url: String
    let image_url: String
}
