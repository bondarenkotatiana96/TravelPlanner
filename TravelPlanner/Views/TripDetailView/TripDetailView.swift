//
//  TripDetailView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/13/22.
//

import SwiftUI

struct TripDetailView: View {
    
    @Binding var trip: Trip
    var tripListVM: TripListViewModel
    
    @StateObject var noteViewModel = NotesViewModel()
    @State var tripNotesText: String = "Enter your trip details here..."
    
    @StateObject var thingToPackVM = ThingToPackViewModel()
    @State var thingToPackName: String = ""
    
    @StateObject var datesViewModel = DatesViewModel()
    @State private var dateFrom = Date()
    @State private var dateTo = Date()
    
    @StateObject var placeToVisitVM = PlaceToVisitViewModel()
    
    @State var searchText = ""
    @State var searching = false
    
    @State private var showShareSheet = false
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "globe.europe.africa")
                Text(trip.name)
                Button {
                    self.showShareSheet = true
                } label: {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.forward")
                        Text("Share")
                    }
                }
            }
            .sheet(isPresented: $showShareSheet) {
                ShareSheet(activityItems: ["I'm going to \(trip.name) in \(trip.dates[0].formatted(.dateTime.month().year()))!"])
                    }
            ZStack {
                Rectangle().fill(Color.yellow)
                    .frame(width: UIScreen.main.bounds.width - 50)
                VStack(alignment: .center) {
                    Text("Dates")
                    HStack {
                        Text("From:")
                        DatePicker("", selection: $dateFrom, displayedComponents: .date)
                        .labelsHidden()
                        .accentColor(.yellow)
                        .onChange(of: dateFrom) { newDate in
                            datesViewModel.updateDate(dates: [newDate, dateTo], trip: trip, tripListViewModel: tripListVM)
                        }
                    }
                    HStack{
                        Text("To:")
                        DatePicker("", selection: $dateTo, displayedComponents: .date)
                            .labelsHidden()
                            .accentColor(.yellow)
                            .onChange(of: dateTo) { newDate in
                                datesViewModel.updateDate(dates: [dateFrom, newDate], trip: trip, tripListViewModel: tripListVM)
                            }
                    }
                }
            }
            .cornerRadius(15)
            
            Text("Notes:")
            TextEditor(text: $tripNotesText)
                .colorMultiply(Color(red: 0.925, green: 0.925, blue: 0.925))
                .frame(width: UIScreen.main.bounds.width - 50, height: 100)
                .cornerRadius(15)
            Button {
                noteViewModel.updateNote(notes: tripNotesText, trip: trip, tripListViewModel: tripListVM)
            } label: {
                Text("Save")
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
                    // TODO: - Search for places *****************************************
                    SearchBar(searchText: $searchText, searching: $searching)
                    ForEach(trip.placesToVisit) { place in
                        HStack {
                            Image(systemName: "globe.europe.africa")
                            Text(place.name)
                        }
                    }
                    Button {
                        // TODO: - Open MAP (Use MapKit) *****************************************
                    } label: {
                        Text("See a map")
                            .font(.system(.caption, design: .monospaced))
                    }
                }
            }
            .listStyle(SidebarListStyle())
        }
        .onAppear {
            tripNotesText = trip.notes
            dateFrom = trip.dates[0]
            dateTo = trip.dates[1]
        }
    }
}

struct TripDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TripDetailView(trip: .constant(Trip(name: "Moscow", dates: [Date(), Date()], notes: "Flight is at 3 pm. Don't forget to print boarding passes!", placesToVisit: [Place(name: "Bolshoy Theater"), Place(name: "Subway"), Place(name: "MSAL"), Place(name: "Red Square")], thingsToPack: [ThingToPack(name: "Passport", isPacked: false), ThingToPack(name: "Vaccination Card", isPacked: false), ThingToPack(name: "Warm Jacket", isPacked: false), ThingToPack(name: "Jeans", isPacked: false)])), tripListVM: TripListViewModel())
        }
    }
}
