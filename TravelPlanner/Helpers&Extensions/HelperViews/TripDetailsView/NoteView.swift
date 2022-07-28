//
//  NoteView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/23/22.
//

import SwiftUI

struct NoteView: View {
    
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    var trip: Trip
    var tripListVM: TripListViewModel
    
    var noteViewModel: NotesViewModel
    @State var tripNotesText: String
    
    var body: some View {
        Text("notes".localized(language))
            .bold()
        TextEditor(text: $tripNotesText)
            .font(Font.custom("EduNSWACTFoundation-Medium", size: 20.0))
            .background(Color("SecondaryLight"))
            .frame(width: UIScreen.main.bounds.width - 50, height: 80)
            .cornerRadius(15)
        Button {
            noteViewModel.updateNote(notes: tripNotesText, trip: trip, tripListViewModel: tripListVM)
            UIApplication.shared.dismissKeyboard()
        } label: {
            ButtonLabel(text: "save".localized(language), width: 110, height: 25, imageSize: 17)
        }
        .onAppear {
            tripNotesText = trip.notes
            UITextView.appearance().backgroundColor = .clear
        }
    }
}
