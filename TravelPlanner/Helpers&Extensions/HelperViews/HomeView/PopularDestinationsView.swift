//
//  PopularDestinationsView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/23/22.
//

import SwiftUI

struct PopularDestinationsView: View {
    @State var topLocations: [TopLocation]
    
    var body: some View {
        Text("Popular destinations in the USA")
            .foregroundColor(Color("Background"))
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
        }
    }
}
