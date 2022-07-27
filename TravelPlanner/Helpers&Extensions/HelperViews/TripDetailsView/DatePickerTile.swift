//
//  DatePickerTile.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/23/22.
//

import SwiftUI

struct DatePickerTile: View {
    
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    var datesViewModel: DatesViewModel
    @State var dateFrom: Date
    @State var dateTo: Date
    var trip: Trip
    var tripListVM: TripListViewModel
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color("CardBackground"))
                .frame(width: UIScreen.main.bounds.width - 70, height: 125)
            VStack(alignment: .center) {
                Text("Dates")
                    .bold()
                    .foregroundColor(Color("CardText"))
                HStack(spacing: 5) {
                    VStack(spacing: 16) {
                        Text("from".localized(language))
                            .foregroundColor(Color("CardText"))
                        Text("to".localized(language))
                            .foregroundColor(Color("CardText"))
                    }
                    VStack {
                        DatePicker("", selection: $dateFrom, displayedComponents: .date)
                        .labelsHidden()
                        .accentColor(Color("AccentColor"))
                        .onChange(of: dateFrom) { newDate in
                            datesViewModel.updateDate(dates: [newDate, dateTo], trip: trip, tripListViewModel: tripListVM)
                        }
                        DatePicker("", selection: $dateTo, displayedComponents: .date)
                            .labelsHidden()
                            .accentColor(Color("AccentColor"))
                            .onChange(of: dateTo) { newDate in
                                datesViewModel.updateDate(dates: [dateFrom, newDate], trip: trip, tripListViewModel: tripListVM)
                            }
                        }
                    }
            }
        }
        .cornerRadius(15)
        .onAppear {
            dateFrom = trip.dates[0]
            dateTo = trip.dates[1]
        }
    }
}
