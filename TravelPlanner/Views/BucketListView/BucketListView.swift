//
//  BucketListView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/14/22.
//

import SwiftUI

struct BucketListView: View {
    
    @ObservedObject var bucketListVM = BucketListViewModel()
    @StateObject private var cityListVM = CityListViewModel()
    
    @State var searchText = ""
    @State var searching = false
    
    var body: some View {
        VStack(alignment: .leading) {
            SearchBar(searchText: $searchText, searching: $searching)
            
            if searching {
            List(cityListVM.cities, id: \.id) { city in
                Text(city.name)
                    .onTapGesture {
                        bucketListVM.createDestination(name: city.name)
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
            .navigationTitle(searching ? "Searching" : "My Bucket List")
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
                if bucketListVM.destinations.isEmpty {
                    EmptyListTile(text: "Search for a destination and add it to your bucket list!")
                        .navigationTitle(searching ? "Searching" : "My Bucket List")
                        .navigationBarTitleDisplayMode(.inline)
                } else {
                    List {
                        ForEach(bucketListVM.destinations) { destination in
                            HStack {
                                Button {
                                    bucketListVM.toggleIsVisited(destination)
                                } label: {
                                    Image(systemName: destination.isVisited ? "heart.fill" : "heart")
                                }
                                Text(destination.name)
                            }
                        }
                        .onDelete(perform: bucketListVM.deleteDestination(index:))
                    }
                    .listStyle(.plain)
                    .navigationTitle(searching ? "Searching" : "My Bucket List")
                    .navigationBarTitleDisplayMode(.inline)
                    .gesture(DragGesture()
                        .onChanged({ _ in
                            searchText = ""
                            UIApplication.shared.dismissKeyboard()
                        })
                    )
                }
            }
        }
    }
}

struct BucketListView_Previews: PreviewProvider {
    static var previews: some View {
        BucketListView()
    }
}
