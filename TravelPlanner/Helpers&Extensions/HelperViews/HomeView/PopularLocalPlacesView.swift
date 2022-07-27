//
//  PopularLocalPlacesView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/23/22.
//

import SwiftUI
import MapKit

struct PopularLocalPlacesView: View {
    
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    @ObservedObject var locationManager: LocationManager
    @State var businesses: [Business]
    @State private var isLoading = false
    
    var body: some View {
        
        
        Text("popular_places".localized(language))
            .foregroundColor(Color("Background"))
        ZStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(businesses) { business in
                        ZStack {
                            AsyncImage(url: URL(string: business.image_url))
                                .overlay(Color("AccentText")).opacity(0.4)
                            VStack(spacing: 20) {
                                Text("\(business.name)")
                                    .font(.title2)
                                    .foregroundColor(Color("Background"))
                                    .frame(width: 235)
                                Link(destination: URL(string: business.url)!, label: {
                                    Text("See details")
                                        .underline()
                                        .foregroundColor(Color("Background"))
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
            
            if isLoading {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ZStack {
                            Rectangle().fill(Color.black.opacity(0.3))
                                .frame(width: 250, height: 170)
                                .cornerRadius(15)
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .tint(Color("Background"))
                                .scaleEffect(2)
                        }
                        ZStack {
                            Rectangle().fill(Color.black.opacity(0.3))
                                .frame(width: 250, height: 170)
                                .cornerRadius(15)
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .tint(Color("Background"))
                                .scaleEffect(2)
                        }
                        ZStack {
                            Rectangle().fill(Color.black.opacity(0.3))
                                .frame(width: 250, height: 170)
                                .cornerRadius(15)
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .tint(Color("Background"))
                                .scaleEffect(2)
                        }
                        ZStack {
                            Rectangle().fill(Color.black.opacity(0.3))
                                .frame(width: 250, height: 170)
                                .cornerRadius(15)
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .tint(Color("Background"))
                                .scaleEffect(2)
                        }
                    }
                }
                .padding(.bottom)
                .padding(.horizontal, 10)
            }
        }
        
        .onAppear {
            fetchPlaces()
        }
    }
    func fetchPlaces() {
        let coordinate = self.locationManager.location != nil ? self.locationManager.location!.coordinate : CLLocationCoordinate2D()
        
        if businesses == [] {isLoading = true}
        YelpService().fetchYelpData(latitude: coordinate.latitude, longitude: coordinate.longitude) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let businesses):
                    self.businesses = businesses
                case .failure(let error):
                    print(error)
                }
            }
            isLoading = false
        }
    }
}
