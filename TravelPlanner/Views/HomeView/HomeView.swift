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
    
    @State var randomDestination: RandomDestination = RandomDestination(city: "", country: "", latitude: 0.0, longitude: 0.0)
    
    var body: some View {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("AccentText"), Color("AccentPink"), Color("AccentColor")]), startPoint: .bottom, endPoint: .top)
                    .edgesIgnoringSafeArea(.all)
                    .hueRotation(.degrees(hueAdjust ? 0 : 40))
                    .animation(Animation.linear(duration: 2.3).repeatForever(autoreverses: true), value: hueAdjust)
                    .onAppear() {
                        hueAdjust.toggle()
                    }
                VStack {
                    Text("Are you ready for an adventure?")
                        .font(.title)
                        .padding(.bottom)
                        .isHidden(!isHidden, remove: !isHidden)
                    Text("\(randomDestination.city), \(randomDestination.country)")
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
//                        Button {
//                            tripListVM.createTrip(name: randomDestination.city, latitude: randomDestination.latitude, longitude: randomDestination.longitude)
//                        } label: {
//                            Text("Add to my trip list")
//                        }
//                        .padding(.leading)
//                        .padding(.bottom)
                    }
                    .isHidden(isHidden, remove: isHidden)
                    
                    Button {
                        RandomDestinationService().getRandomDestination { result in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let randomDestination):
                                    self.randomDestination = randomDestination
                                case .failure(let error):
                                    print(error)
                                }
                            }
                        }
                        isHidden.toggle()
                    } label: {
                        ButtonLabel(text: isHidden ? "Get a random destination" : "Get another destination", imageName: "airplane", width: 320, height: 50, imageSize: 30)
                    }
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
