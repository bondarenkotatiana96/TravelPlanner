//
//  TripListView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/12/22.
//

import SwiftUI

struct TripListView: View {
    
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    @ObservedObject var tripListVM = TripListViewModel()
    @StateObject private var cityListVM = CityListViewModel()
    
    @State var searchText = ""
    @State var searching = false
    
    @State private var latitude = 0.0
    @State private var longitude = 0.0
    
    let scheduler = NotificationScheduler()
    
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
                    .navigationTitle(searching ? "searching".localized(language) : "my_trips".localized(language))
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        if searching {
                            Button("Cancel".localized(language)) {
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
                        EmptyListTile(text: "empty_trips".localized(language))
                            .navigationTitle(searching ? "searching".localized(language) : "my_trips".localized(language))
                            .navigationBarTitleDisplayMode(.inline)
                    } else {
                        TripList(tripListVM: tripListVM, searching: searching)
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
