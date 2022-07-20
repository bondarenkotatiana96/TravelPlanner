//
//  HomeView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/20/22.
//

import SwiftUI

struct HomeView: View {
    
    @State private var hueAdjust = false
    @State var isHidden = true
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("AccentText"), Color("AccentPink"), Color("AccentColor")]), startPoint: .bottom, endPoint: .top)
                    .edgesIgnoringSafeArea(.all)
                    .hueRotation(.degrees(hueAdjust ? 0 : 40))
                    .animation(Animation.linear(duration: 2.3).repeatForever(autoreverses: true), value: hueAdjust)
                    .onAppear() {
                        hueAdjust.toggle()
                    }
                VStack {
                    Text("London")
                        .font(.largeTitle)
                        .padding(.bottom, 30)
                        .isHidden(isHidden, remove: isHidden)
                    VStack(alignment: .leading) {
                        Text("Featured Events")
                            .italic()
                            .padding(.leading)
                        ScrollView(.horizontal) {
                            HStack(spacing: 20) {
                                ForEach(0..<10) {
                                    Text("Item \($0)")
                                        .foregroundColor(.white)
                                        .font(.largeTitle)
                                        .frame(width: 280, height: 200)
                                        .background(.red)
                                }
                            }
                        }
                        .padding(.bottom)
                        .padding(.horizontal, 10)
                        Button {
                            // TODO: - Add to trip list and move user to trip list
                        } label: {
                            Text("Add to my trip list")
                        }
                        .padding(.leading)
                        .padding(.bottom)
                    }
                    .isHidden(isHidden, remove: isHidden)
                    
                    Button {
                        // Get a random Destination
                        isHidden.toggle()
                    } label: {
                        ButtonLabel(text: isHidden ? "Get a random destination" : "Get another destination", imageName: "airplane", width: 320, height: 50, imageSize: 30)
                    }
                }
            }
            .navigationTitle("Are you ready for an adventure?")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
