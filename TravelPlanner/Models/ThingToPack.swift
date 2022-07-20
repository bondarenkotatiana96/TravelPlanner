//
//  ThingToPack.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/12/22.
//

import Foundation

struct ThingToPack: Equatable, Identifiable, Codable {
    var name: String
    var isPacked: Bool
    var id = UUID()
}
