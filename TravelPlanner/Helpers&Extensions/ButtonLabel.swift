//
//  ButtonLabel.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/16/22.
//

import SwiftUI

struct ButtonLabel: View {
    
    var text: String
    var imageName: String?
    var width: CGFloat
    var height: CGFloat
    var imageSize: CGFloat
    
    var body: some View {
        HStack {
            Image(systemName: imageName ?? "")
                .foregroundColor(Color("AccentPink"))
                .font(.system(size: imageSize))
            Text(text)
                .fontWeight(.bold)
                .foregroundColor(Color("SecondaryDark"))
        }
        .frame(width: width, height: height)
        .background(Color.accentColor)
        .clipShape(Capsule())
    }
}
