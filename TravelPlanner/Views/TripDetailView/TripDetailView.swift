//
//  TripDetailView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/13/22.
//

import SwiftUI
import MapKit

struct TripDetailView: View {
    
    @Binding var trip: Trip
    var tripListVM: TripListViewModel
    
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
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.75773, longitude: -73.985708), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    var body: some View {
        ZStack {
        VStack {
            HStack(spacing: 20) {
                Text(trip.name)
                    .bold()
                    .font(.system(size: 32))
                    .foregroundColor(Color("AccentText"))
                Button {
                    self.showShareSheet = true
                } label: {
                    ButtonLabel(text: "Share", imageName: "arrowshape.turn.up.forward", width: 110, height: 25, imageSize: 17)
                }
            }
            .frame(height: 80)
            .sheet(isPresented: $showShareSheet) {
                ShareSheet(activityItems: ["I'm going to \(trip.name) in \(trip.dates[0].formatted(.dateTime.month().year()))!"])
                    }
            ZStack {
                Rectangle().fill(Color("BackgroundYellow"))
                    .frame(width: UIScreen.main.bounds.width - 70)
                VStack(alignment: .center) {
                    Text("Dates")
                        .bold()
                    HStack(spacing: 5) {
                        VStack(spacing: 16) {
                            Text("From:")
                            Text("To:")
                        }
                        VStack {
                            DatePicker("", selection: $dateFrom, displayedComponents: .date)
                            .labelsHidden()
                            .accentColor(.yellow)
                            .onChange(of: dateFrom) { newDate in
                                datesViewModel.updateDate(dates: [newDate, dateTo], trip: trip, tripListViewModel: tripListVM)
                            }
                            DatePicker("", selection: $dateTo, displayedComponents: .date)
                                .labelsHidden()
                                .accentColor(.yellow)
                                .onChange(of: dateTo) { newDate in
                                    datesViewModel.updateDate(dates: [dateFrom, newDate], trip: trip, tripListViewModel: tripListVM)
                                }
                            }
                        }
                }
            }
            .cornerRadius(15)
            
            Text("Notes:")
                .bold()
            TextEditor(text: $tripNotesText)
                .colorMultiply(Color("SecondaryLight"))
                .frame(width: UIScreen.main.bounds.width - 50, height: 100)
                .cornerRadius(15)
            Button {
                noteViewModel.updateNote(notes: tripNotesText, trip: trip, tripListViewModel: tripListVM)
            } label: {
                ButtonLabel(text: "Save", width: 110, height: 25, imageSize: 17)
            }
            
            List {
                Section("Things to pack") {
                    TextField("Add...", text: $thingToPackName)
                        .onSubmit {
                            thingToPackVM.createThingToPack(thingToPack: ThingToPack(name: thingToPackName, isPacked: false), trip: trip, tripListViewModel: tripListVM)
                            thingToPackName = ""
                        }
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
                Section("Places to visit") {
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
                        ButtonLabel(text: "See a map", imageName: "map", width: 150, height: 25, imageSize: 17)
                    }
                }
            }
            .listStyle(SidebarListStyle())
        }
            
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
                }.edgesIgnoringSafeArea(.all)
                VStack {
                    Button {
                        showMap()
                    } label: {
                        ButtonLabel(text: "Close", imageName: "xmark.circle.fill", width: 100, height: 30, imageSize: 20)
                    }
                    Spacer()
                }
            }
            .isHidden(isHidden, remove: isHidden)
        }
        .onAppear {
            tripNotesText = trip.notes
            dateFrom = trip.dates[0]
            dateTo = trip.dates[1]
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
