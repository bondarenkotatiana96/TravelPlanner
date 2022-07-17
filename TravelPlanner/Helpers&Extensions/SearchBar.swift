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
            Rectangle().fill(Color(red: 0.976, green: 0.933, blue: 0.718))
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(red: 0.192, green: 0.047, blue: 0.024))
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
            .foregroundColor(Color(red: 0.651, green: 0.651, blue: 0.651))
            .padding(.leading, 13)
            
        }
            .frame(height: 40)
            .cornerRadius(20)
            .padding()
    }
}


