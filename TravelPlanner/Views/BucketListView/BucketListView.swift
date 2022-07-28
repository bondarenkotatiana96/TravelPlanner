//
//  BucketListView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/14/22.
//

import SwiftUI

struct BucketListView: View {
    
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    @ObservedObject var bucketListVM = BucketListViewModel()
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
                    .navigationTitle(searching ? "searching".localized(language) : "bucket_list".localized(language))
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        if searching {
                            Button("cancel".localized(language)) {
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
                        EmptyListTile(text: "empty_bucket_list".localized(language))
                            .navigationTitle(searching ? "searching".localized(language) : "bucket_list".localized(language))
                            .navigationBarTitleDisplayMode(.inline)
                    } else {
                        BucketList(bucketListVM: bucketListVM, searching: searching)
                    }
                }
            }
            .navigationTitle(searching ? "searching".localized(language) : "bucket_list".localized(language))
            .onAppear {
                bucketListVM.loadFromPersistenceStore()
            }
        }
    }
}

struct BucketListView_Previews: PreviewProvider {
    static var previews: some View {
        BucketListView()
    }
}
