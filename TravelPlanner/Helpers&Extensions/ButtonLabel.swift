//
//  ButtonLabel.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/16/22.
//

import SwiftUI

struct ButtonLabel: View {
    
    var text: String
    var imageName: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(Color(red: 1, green: 0.31, blue: 0.388))
                .font(.system(size: 32))
            Text(text)
                .bold()
                .foregroundColor(Color(red: 0.302, green: 0.298, blue: 0.298))
                .padding(.trailing)
        }
        .frame(width: 300, height: 50)
        .background(Color(red: 1, green: 0.71, blue: 0.541))
        .clipShape(Capsule())
    }
}
