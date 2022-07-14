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
//                    .gesture(DragGesture()
//                        .onChanged({ _ in
//                            searchText = ""
//                            UIApplication.shared.dismissKeyboard()
//                        })
//                    )
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

struct EmptyListTile: View {
    var body: some View {
        VStack {
            Divider()
        ZStack {
            Rectangle().fill(Color.pink)
            Text("Search for a destination and plan your next trip")
                .font(.system(.caption, design: .monospaced))
                    .padding()
        }.cornerRadius(12)
            .frame(width: UIScreen.main.bounds.width - 50)
            .padding(.top)
            .padding(.bottom, 250)
        }
    }
}

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
