//
//  PopularDestinationsView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/23/22.
//

import SwiftUI

struct PopularDestinationsView: View {
    
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    @State var topLocations: [TopLocation]
    @State private var isLoading = false
    
    var body: some View {
        Text("popular_destinations".localized(language))
            .foregroundColor(Color("Background"))
        ZStack {
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
            
            // Show empty tiles while info is loading
            if isLoading {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ZStack {
                            Rectangle().fill(.ultraThinMaterial)
                                .frame(width: 230, height: 190)
                                .cornerRadius(15)
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .tint(Color("Background"))
                                .scaleEffect(2)
                        }
                        ZStack {
                            Rectangle().fill(.ultraThinMaterial)
                                .frame(width: 230, height: 190)
                                .cornerRadius(15)
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .tint(Color("Background"))
                                .scaleEffect(2)
                        }
                        ZStack {
                            Rectangle().fill(.ultraThinMaterial)
                                .frame(width: 230, height: 190)
                                .cornerRadius(15)
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .tint(Color("Background"))
                                .scaleEffect(2)
                        }
                        ZStack {
                            Rectangle().fill(.ultraThinMaterial)
                                .frame(width: 230, height: 190)
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
            fetchCities()
        }
    }
    
    func fetchCities() {
        if topLocations == [] {isLoading = true}
        TopLocationService().getTopLocations() { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let topLocations):
                    self.topLocations = topLocations
                case .failure(let error):
                    print(error)
                }
            }
            isLoading = false
        }
    }
}
