//
//  TripListView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/12/22.
//

import SwiftUI

struct TripListView: View {
    
    @ObservedObject var tripListVM = TripListViewModel()
    @StateObject private var cityListVM = CityListViewModel()
    
    @State var searchText = ""
    @State var searching = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                SearchBar(searchText: $searchText, searching: $searching)
                if searching {
                List(cityListVM.cities, id: \.id) { city in
                    Text(city.name)
                        .onTapGesture {
                            tripListVM.createTrip(name: city.name)
                            searching = false
                            searchText = ""
                            UIApplication.shared.dismissKeyboard()
                        }
                }
                .listStyle(.plain)
                .onChange(of: searchText) { value in
                        if !value.isEmpty && value.count > 2 {
                            cityListVM.search(name: value)
                        } else {
                            cityListVM.cities.removeAll()
                        }
                    }
                .navigationTitle(searching ? "Searching" : "My Trips")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    if searching {
                        Button("Cancel") {
                            withAnimation {
                                searchText = ""
                                searching = false
                                UIApplication.shared.dismissKeyboard()
                            }
                        }
                    }
                }
                .gesture(DragGesture()
                    .onChanged({ _ in
                        searchText = ""
                        UIApplication.shared.dismissKeyboard()
                    })
                )
                } else {
                
                if tripListVM.trips.isEmpty {
                    EmptyListTile()
                        .navigationTitle(searching ? "Searching" : "My Trips")
                        .navigationBarTitleDisplayMode(.inline)
                } else {
                    List {
                        ForEach(tripListVM.trips) { trip in
                            NavigationLink {
                                TripDetailView(trip: .constant(trip), tripListVM: tripListVM)
                            } label: {
                                HStack {
                                    Image(systemName: "globe.europe.africa")
                                    Text(trip.name)
                                }
                            }
                        }
                        .onDelete(perform: tripListVM.deleteTrip(index:))
                    }
                    .listStyle(.plain)
                    .navigationTitle(searching ? "Searching" : "My Trips")
                    .navigationBarTitleDisplayMode(.inline)
                    }
                }
            }
        }
    }
}

struct TripListView_Previews: PreviewProvider {
    static var previews: some View {
        TripListView()
    }
}

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}