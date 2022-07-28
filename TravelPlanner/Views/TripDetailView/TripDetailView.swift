//
//  TripDetailView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/13/22.
//

import SwiftUI
import MapKit

struct TripDetailView: View {
    
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    @Binding var trip: Trip
    var tripListVM: TripListViewModel
    
    // Updating trip details
    @StateObject var noteViewModel = NotesViewModel()
    @State var tripNotesText: String = ""
    
    @StateObject var thingToPackVM = ThingToPackViewModel()
    @State var thingToPackName: String = ""
    
    @StateObject var datesViewModel = DatesViewModel()
    @State private var dateFrom = Date()
    @State private var dateTo = Date()
    
    @StateObject var placeToVisitVM = PlaceToVisitViewModel()
    @State var placeToVisitName: String = ""
    
    @State var searching = false
    @State var isHidden = true
    
    @State private var showShareSheet = false
    
    @StateObject private var placeSearchVM = LocalSearchViewModel()
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.75773, longitude: -73.985708),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 20) {
                    Text(trip.name)
                        .bold()
                        .font(.system(size: 25))
                        .foregroundColor(Color("AccentText"))
                    Button {
                        self.showShareSheet = true
                    } label: {
                        ButtonLabel(
                            text: "share".localized(language),
                            imageName: "arrowshape.turn.up.forward",
                            width: 110, height: 25, imageSize: 17
                        )
                    }
                }
                .frame(height: 80)
                // Showing share sheet by clicking on "Share" button
                .sheet(isPresented: $showShareSheet) {
                        ShareSheet(activityItems: ["I'm going to \(trip.name) in \(trip.dates[0].formatted(.dateTime.month().year()))!"])
                    }
                
                DatePickerTile(datesViewModel: datesViewModel, dateFrom: dateFrom, dateTo: dateTo, trip: trip, tripListVM: tripListVM)
                NoteView(trip: trip, tripListVM: tripListVM, noteViewModel: noteViewModel, tripNotesText: tripNotesText)
                
                List {
                    // Things to pack list section
                    Section("to_pack".localized(language)) {
                        TextField("add".localized(language), text: $thingToPackName)
                            .onSubmit {
                                thingToPackVM.createThingToPack(thingToPack: ThingToPack(name: thingToPackName, isPacked: false), trip: trip, tripListViewModel: tripListVM)
                                thingToPackName = ""
                            }
                            .submitLabel(.done)
                        ForEach(trip.thingsToPack) { item in
                            HStack {
                                Button {
                                    thingToPackVM.toggleIsPacked(thingToPack: item, trip: trip, tripListViewModel: tripListVM)
                                } label: {
                                    Image(systemName: item.isPacked ? "checkmark.square" : "square")
                                        .resizable()
                                        .frame(width: 23, height: 23)
                                }
                                Text(item.name)
                            }
                        }
                        .onDelete { indexSet in
                            thingToPackVM.deleteThingToPack(trip: trip, tripListViewModel: tripListVM, at: indexSet)
                        }
                    }
                    // Places to visit list section + search for places to visit
                    Section("to_visit".localized(language)) {
                        SearchBar(searchText: $placeSearchVM.poiText, searching: $searching)
                        if searching {
                            ForEach(placeSearchVM.viewData) { place in
                                VStack(alignment: .leading) {
                                    Text(place.title)
                                    Text(place.subtitle)
                                        .foregroundColor(.secondary)
                                }
                                .onTapGesture {
                                    placeToVisitVM.createPlaceToVisit(name: place.title, latitude: place.latitude, longitude: place.longitude, trip: trip, tripListViewModel: tripListVM)
                                    placeSearchVM.poiText = ""
                                    searching = false
                                    UIApplication.shared.dismissKeyboard()
                                }
                            }
                        } else {
                            ForEach(trip.placesToVisit) { place in
                                HStack {
                                    Image(systemName: "mappin.and.ellipse")
                                        .foregroundColor(Color("AccentPink"))
                                        .font(.system(size: 20))
                                    Text(place.name)
                                }
                            }
                            .onDelete { indexSet in
                                placeToVisitVM.deletePlaceToVisit(trip: trip, tripListViewModel: tripListVM, at: indexSet)
                            }
                        }
                        
                        Button {
                            showMap()
                        } label: {
                            ButtonLabel(text: "see_map".localized(language), imageName: "map", width: 150, height: 25, imageSize: 17)
                        }
                    }
                }
                .listStyle(SidebarListStyle())
                .frame(minHeight: 400)
                .edgesIgnoringSafeArea(.bottom)
            }
                // Map is showed when user clicks on "Show a map button"
                ZStack{
                    Map(coordinateRegion: $region, interactionModes: MapInteractionModes.all, annotationItems: trip.placesToVisit){
                        place in
                        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)) {
                            Image(systemName: "mappin").foregroundColor(Color("AccentPink"))
                                .font(.system(size: 30))
                            Text(place.name)
                                .font(.subheadline)
                                .fontWeight(.bold)
                        }
                    }
                    .edgesIgnoringSafeArea(.all)
                    VStack {
                        Button {
                            showMap()
                        } label: {
                            ButtonLabel(text: "close".localized(language), imageName: "xmark.circle.fill", width: 100, height: 30, imageSize: 20)
                        }
                        .padding(.top, 150)
                        Spacer()
                    }
                }
                .isHidden(isHidden, remove: isHidden)
            }
            .onAppear {
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: trip.latitude, longitude: trip.longitude), span: MKCoordinateSpan(latitudeDelta: 0.8, longitudeDelta: 0.8))
            }
    }
    
    private func showMap() {
        isHidden.toggle()
    }
}

struct TripDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TripDetailView(trip: .constant(Trip(name: "Moscow", dates: [Date(), Date()], notes: "Flight is at 3 pm. Don't forget to print boarding passes!", placesToVisit: [Place(name: "Bolshoy Theater", latitude: 55.741469, longitude: 37.615561), Place(name: "Subway", latitude: 55.741469, longitude: 37.615561), Place(name: "MSAL", latitude: 55.741469, longitude: 37.615561), Place(name: "Red Square", latitude: 55.741469, longitude: 37.615561)], thingsToPack: [ThingToPack(name: "Passport", isPacked: false), ThingToPack(name: "Vaccination Card", isPacked: false), ThingToPack(name: "Warm Jacket", isPacked: false), ThingToPack(name: "Jeans", isPacked: false)], latitude: 55.741469, longitude: 37.615561)), tripListVM: TripListViewModel())
        }
    }
}
