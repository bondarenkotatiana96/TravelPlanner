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
                
                List(cityListVM.cities, id: \.id) { city in
                    Text(city.name)
                        .onTapGesture {
                            tripListVM.createTrip(name: city.name)
                            searching = false
                            searchText = ""
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
                
                List {
                    ForEach(tripListVM.trips) { trip in
                        NavigationLink {
                            // TRIP DETAILS VIEW
                        } label: {
                            HStack {
                                Image(systemName: "globe.europe.africa")
                                Text(trip.name)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle(searching ? "Searching" : "My Trips")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    if searching {
                        Button("Cancel") {
                            searchText = ""
                            withAnimation {
                                searching = false
                                UIApplication.shared.dismissKeyboard()
                            }
                        }
                    }
                }
                .gesture(DragGesture()
                    .onChanged({ _ in
                        UIApplication.shared.dismissKeyboard()
                    })
                )
            }
        }
    }
}

struct TripListView_Previews: PreviewProvider {
    static var previews: some View {
        TripListView()
    }
}

struct SearchBar: View {
    
    @Binding var searchText: String
    @Binding var searching: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.yellow)
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("I want to go to...", text: $searchText) { startedEditing in
                    if startedEditing {
                        withAnimation {
                            searching = true
                        }
                    }
                } onCommit: {
                    withAnimation {
                        searching = false
                        searchText = ""
                    }
                }
            }
            .foregroundColor(.gray)
            .padding(.leading, 13)
        }
            .frame(height: 40)
            .cornerRadius(20)
            .padding()
    }
}

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
