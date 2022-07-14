//
//  BucketListDestination.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/14/22.
//

import Foundation

struct BucketListDestination: Equatable, Identifiable {
    var name: String
    var isVisited: Bool = false
    var id = UUID()
}
