//
//  TripListView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/12/22.
//

import SwiftUI

struct TripListView: View {
    
    @ObservedObject var viewModel = TripListViewModel()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct TripListView_Previews: PreviewProvider {
    static var previews: some View {
        TripListView()
    }
}
