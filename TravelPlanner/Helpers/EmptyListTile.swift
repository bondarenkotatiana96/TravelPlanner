//
//  EmptyListTile.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/14/22.
//

import Foundation
import SwiftUI

struct EmptyListTile: View {
    var body: some View {
        VStack {
            Divider()
        ZStack {
            Rectangle().fill(Color.pink)
            Text("Search for a destination and plan your next trip")
                .font(.system(.caption, design: .monospaced))
                    .padding()
        }.cornerRadius(12)
            .frame(width: UIScreen.main.bounds.width - 50)
            .padding(.top)
            .padding(.bottom, 250)
        }
    }
}
