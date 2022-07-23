//
//  HomeView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/20/22.
//

import SwiftUI
import MapKit

struct HomeView: View {
    
    @ObservedObject private var locationManager = LocationManager()
    
    @State private var hueAdjust = false
    @State var isHidden = true
    
    @State var randomDestination: RandomDestination = RandomDestination(city: "", country: "", latitude: 0.0, longitude: 0.0)
    @State var topLocations: [TopLocation] = []
    @State var businesses: [Business] = []
    
    var body: some View {
        
        let coordinate = self.locationManager.location != nil ? self.locationManager.location!.coordinate : CLLocationCoordinate2D()
        NavigationView{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("AccentText"), Color("AccentPink"), Color("AccentColor")]), startPoint: .bottom, endPoint: .top)
                    .edgesIgnoringSafeArea(.all)
                    .hueRotation(.degrees(hueAdjust ? 0 : 60))
                    .animation(Animation.linear(duration: 2.3).repeatForever(autoreverses: true), value: hueAdjust)
                    .onAppear() {
                        hueAdjust.toggle()
                    }
                VStack {
                    Text("Popular destinations in the USA")
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(topLocations) { location in
                                VStack {
                                    Text("\(location.name)")
                                        .foregroundColor(Color("AccentText"))
                                        .font(.title)
                                    Text("\(location.snippet)")
                                        .foregroundColor(Color("AccentText"))
                                        .font(.caption)
                                        .padding(.horizontal)
                                }
                                .frame(width: 230, height: 190)
                                .background(.ultraThinMaterial)
                                .cornerRadius(15)
                            }
                        }
                    }
                    .padding(.bottom)
                    .padding(.horizontal, 10)
                    
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
                    
                    Text("Feeling adventurous?")
                        .foregroundColor(Color("BackgroundYellow"))
                    Button {
                        if isHidden {
                            RandomDestinationService().getRandomDestination { result in
                                DispatchQueue.main.async {
                                    switch result {
                                    case .success(let randomDestination):
                                        self.randomDestination = randomDestination
                                    case .failure(let error):
                                        print(error)
                                    }
                                }
                            }
                            isHidden.toggle()
                        } else {
                            isHidden.toggle()
                        }
                    } label: {
                        ButtonLabel(text: isHidden ? "Get a random destination" : "Close", imageName: "airplane", width: 280, height: 50, imageSize: 25)
                    }
                        
                    Text("\(randomDestination.city), \(randomDestination.country)")
                        .foregroundColor(Color("BackgroundYellow"))
                        .font(.system(size: 20))
                        .isHidden(isHidden, remove: isHidden)
                }
                .navigationTitle("Explore the world!")
                .navigationBarTitleDisplayMode(.inline)
            }
            .onAppear {
                TopLocationService().getTopLocations() { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let topLocations):
                            self.topLocations = topLocations
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
                
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
            // 1. Add AppDelegate
            // 2. Add loaders (activity indicator class by apple)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
