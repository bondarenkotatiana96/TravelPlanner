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
    
    @State private var latitude = 0.0
    @State private var longitude = 0.0
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                SearchBar(searchText: $searchText, searching: $searching)
                if searching {
                List(cityListVM.cities, id: \.id) { city in
                    Text(city.name)
                        .onTapGesture {
                            CitySearchService().getCoordinates(location: city.name) { result in
                                DispatchQueue.main.async {
                                    switch result {
                                    case .success(let coordinatesResult):
                                        tripListVM.createTrip(name: city.name, latitude: coordinatesResult[1], longitude: coordinatesResult[0])
                                    case .failure(let error):
                                        print(error)
                                    }
                                }
                            }
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
                    EmptyListTile(text: "Search for a destination and plan your next trip!")
                        .navigationTitle(searching ? "Searching" : "My Trips")
                        .navigationBarTitleDisplayMode(.inline)
                } else {
                    List {
                        ForEach(tripListVM.trips) { trip in
                            NavigationLink {
                                TripDetailView(trip: .constant(trip), tripListVM: tripListVM)
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
                    .navigationTitle(searching ? "Searching" : "My Trips")
                    .navigationBarTitleDisplayMode(.inline)
                    }
                }
            }
            .onAppear {
                tripListVM.loadFromPersistenceStore()
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
