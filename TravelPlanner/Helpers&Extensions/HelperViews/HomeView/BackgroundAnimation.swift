//
//  BackgroundAnimation.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/23/22.
//

import SwiftUI

struct BackgroundAnimation: View {
    @State var hueAdjust: Bool
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color("AccentText"), Color("AccentPink"), Color("AccentColor")]), startPoint: .bottom, endPoint: .top)
            .edgesIgnoringSafeArea(.all)
            .hueRotation(.degrees(hueAdjust ? 0 : 60))
            .animation(Animation.linear(duration: 2.3).repeatForever(autoreverses: true), value: hueAdjust)
            .onAppear() {
                hueAdjust.toggle()
            }
    }
}
