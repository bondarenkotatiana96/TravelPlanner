//
//  EmptyListTile.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/14/22.
//

import Foundation
import SwiftUI

struct EmptyListTile: View {
    
    var text: String
    
    var body: some View {
        VStack {
            Divider()
        ZStack {
            RoundedRectangle(cornerRadius: 50).fill(Color(red: 1, green: 0.31, blue: 0.388, opacity: 0.3))
                .position(x: 160, y: 170)
            RoundedRectangle(cornerRadius: 50).fill(Color(red: 1, green: 0.71, blue: 0.541))
            Text(text)
                .font(.system(.headline, design: .monospaced))
                .padding()
        }
            .frame(width: UIScreen.main.bounds.width - 50)
            .padding(.top)
            .padding(.bottom, 250)
        }
    }
}
