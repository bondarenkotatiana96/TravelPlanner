//
//  TripList.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/23/22.
//

import SwiftUI

struct TripList: View {
    
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    @ObservedObject var tripListVM: TripListViewModel
    @State var searching: Bool
    
    var body: some View {
        List {
            ForEach(tripListVM.trips) { trip in
                NavigationLink {
                    ScrollView { TripDetailView(trip: .constant(trip), tripListVM: tripListVM) }
                } label: {
                    HStack(spacing: 22) {
                        Image(systemName: "globe.europe.africa")
                            .foregroundColor(Color("AccentColor"))
                            .font(.system(size: 30))
                        Text(trip.name)
                    }
                }
            }
            .onDelete(perform: tripListVM.deleteTrip(index:))
            .frame(minHeight: 50)
            .listRowSeparator(.hidden, edges: .top)
            .listRowSeparatorTint(Color("AccentColor"), edges: .bottom)
        }
        .listStyle(.plain)
        .navigationTitle(searching ? "searching".localized(language) : "my_trips".localized(language))
        .navigationBarTitleDisplayMode(.inline)
    }
}
