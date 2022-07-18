//
//  SearchBar.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/14/22.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    @Binding var searching: Bool
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color("BackgroundYellow"))
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color("AccentText"))
                TextField("I want to go to...", text: $searchText) { startedEditing in
                    if startedEditing {
                        withAnimation {
                            searching = true
                        }
                    }
                } onCommit: {
                    withAnimation {
                        searching = false
                        searchText = ""
                    }
                }
                
            }
            .padding(.leading, 13)
            
        }
            .frame(height: 40)
            .cornerRadius(20)
            .padding()
    }
}


