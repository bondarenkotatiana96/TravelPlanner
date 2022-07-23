//
//  PopularLocalPlacesView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/23/22.
//

import SwiftUI
import MapKit

struct PopularLocalPlacesView: View {
    @ObservedObject var locationManager: LocationManager
    @State var businesses: [Business]
    
    var body: some View {
        let coordinate = self.locationManager.location != nil ? self.locationManager.location!.coordinate : CLLocationCoordinate2D()
        
        Text("Popular local places")
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(businesses) { business in
                    ZStack {
                        AsyncImage(url: URL(string: business.image_url))
                            .overlay(Color("AccentText")).opacity(0.4)
                        VStack(spacing: 20) {
                            Text("\(business.name)")
                                .font(.title2)
                                .foregroundColor(Color("BackgroundYellow"))
                                .frame(width: 235)
                            Link(destination: URL(string: business.url)!, label: {
                                Text("See details")
                                    .underline()
                            })
                        }
                    }
                    .frame(width: 250, height: 170)
                    .cornerRadius(15)
                }
            }
        }
        .padding(.bottom)
        .padding(.horizontal, 10)
        .onAppear {
            YelpService().fetchYelpData(latitude: coordinate.latitude, longitude: coordinate.longitude) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let businesses):
                        self.businesses = businesses
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
}
