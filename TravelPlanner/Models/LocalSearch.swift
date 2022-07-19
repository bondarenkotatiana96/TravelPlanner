//
//  LocalSearch.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/19/22.
//

import Foundation
import MapKit
import Combine

struct LocalSearchData: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    
    init(mapItem: MKMapItem) {
        self.title = mapItem.name ?? ""
        self.subtitle = mapItem.placemark.title ?? ""
    }
}
