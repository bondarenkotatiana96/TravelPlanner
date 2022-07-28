//
//  EmptyListTile.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/14/22.
//

import SwiftUI

struct EmptyListTile: View {
    
    var text: String
    
    var body: some View {
        VStack {
            Divider()
        ZStack {
            RoundedRectangle(cornerRadius: 50).fill(Color.accentColor)
                .shadow(color: Color("AccentPink"), radius: 15, x: -10, y: 15)
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
