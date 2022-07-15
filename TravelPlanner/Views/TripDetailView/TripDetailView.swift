//
//  TripDetailView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/13/22.
//

import SwiftUI

struct TripDetailView: View {
    
    @StateObject var noteViewModel = NotesViewModel()
    
    @Binding var trip: Trip
    var tripListVM: TripListViewModel
    
    @State var tripNotesText: String = "Enter your trip details here..."
    
    @State var searchText = ""
    @State var searching = false
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "globe.europe.africa")
                Text(trip.name)
            }
            ZStack {
                Rectangle().fill(Color.yellow)
                VStack {
                    Text("Dates")
                        .font(.system(.caption, design: .monospaced))
                    HStack {
                        Text("21.03.2022-30.03.2022")
                        Button {
                            // TODO: - Open Calendar for updating dates
                        } label: {
                            Text("Edit")
                                .font(.system(.caption, design: .monospaced))
                        }
                    }
                    Button {
                        // TODO: - SHARE on social media
                    } label: {
                        HStack {
                            Image(systemName: "arrowshape.turn.up.forward")
                            Text("Share")
                        }
                    }
                }
            }
            .cornerRadius(15)
            TextEditor(text: trip.notes != "" ? $trip.notes : $tripNotesText)
                .colorMultiply(Color(red: 0.925, green: 0.925, blue: 0.925))
                .frame(width: UIScreen.main.bounds.width - 50, height: 100)
                .cornerRadius(15)
            Button {
                noteViewModel.updateNote(note: tripNotesText, trip: trip, tripListViewModel: tripListVM)
            } label: {
                Text("Save")
            }
            
            List {
                Section("Things to pack") {
                    ForEach(trip.thingsToPack) { item in
                        HStack {
                            Image(systemName: "square")
                            Text(item.name)
                        }
                    }
                }
                Section("Places to visit") {
                    // TODO: - Search for places
                    SearchBar(searchText: $searchText, searching: $searching)
                    ForEach(trip.placesToVisit) { place in
                        HStack {
                            Image(systemName: "globe.europe.africa")
                            Text(place.name)
                        }
                    }
                    Button {
                        // TODO: - Open MAP (Use MapKit)
                    } label: {
                        Text("See a map")
                            .font(.system(.caption, design: .monospaced))
                    }
                }
            }
            .listStyle(SidebarListStyle())
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
