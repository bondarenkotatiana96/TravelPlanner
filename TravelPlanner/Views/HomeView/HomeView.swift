//
//  HomeView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/20/22.
//

import SwiftUI
import MapKit

struct HomeView: View {
    
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    @ObservedObject private var locationManager = LocationManager()
    
    @State private var hueAdjust = true
    @State var isHidden = true
    
    @State var randomDestination: RandomDestination = RandomDestination(city: "", country: "", latitude: 0.0, longitude: 0.0)
    @State var topLocations: [TopLocation] = []
    @State var businesses: [Business] = []
    
    var body: some View {
        NavigationView{
            ZStack {
                BackgroundAnimation(hueAdjust: hueAdjust)
                VStack {
                    PopularDestinationsView(topLocations: topLocations)
                    PopularLocalPlacesView(locationManager: locationManager, businesses: businesses)
                    RandomDestinationView(randomDestination: randomDestination, isHidden: isHidden)
                }
                .navigationTitle("explore_title".localized(language))
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
