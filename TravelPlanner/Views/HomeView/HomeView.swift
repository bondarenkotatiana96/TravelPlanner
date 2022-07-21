//
//  HomeView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/20/22.
//

import SwiftUI
import MapKit

struct HomeView: View {
    
    @ObservedObject private var locationManager = LocationManager()
    
    @State private var hueAdjust = false
    @State var isHidden = true
    
    @State var randomDestination: RandomDestination = RandomDestination(city: "", country: "", latitude: 0.0, longitude: 0.0)
    
    var body: some View {
        
        let coordinate = self.locationManager.location != nil ? self.locationManager.location!.coordinate : CLLocationCoordinate2D()
        NavigationView{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("AccentText"), Color("AccentPink"), Color("AccentColor")]), startPoint: .bottom, endPoint: .top)
                    .edgesIgnoringSafeArea(.all)
                    .hueRotation(.degrees(hueAdjust ? 0 : 40))
                    .animation(Animation.linear(duration: 2.3).repeatForever(autoreverses: true), value: hueAdjust)
                    .onAppear() {
                        hueAdjust.toggle()
                    }
                VStack {
                    Text("Popular destinations in the USA")
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            ForEach(0..<10) {
                                Text("Item \($0)")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                                    .frame(width: 250, height: 170)
                                    .background(Color("BackgroundYellow"))
                            }
                        }
                    }
                    .padding(.bottom)
                    .padding(.horizontal, 10)
                    
                    Text("Local places")
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            ForEach(0..<10) {
                                Text("Item \($0)")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                                    .frame(width: 250, height: 170)
                                    .background(Color("BackgroundYellow"))
                            }
                        }
                    }
                    .padding(.bottom)
                    .padding(.horizontal, 10)
                    
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
                        ButtonLabel(text: isHidden ? "Get a random destination" : "Close", imageName: "airplane", width: 320, height: 50, imageSize: 30)
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 50).fill(Color.accentColor).frame(width: UIScreen.main.bounds.width - 70, height: 50)
                        Text("\(randomDestination.city), \(randomDestination.country)")
                            .foregroundColor(Color("AccentText"))
                            .font(.system(size: 20))
                    }
                    .isHidden(isHidden, remove: isHidden)
                }
                .navigationTitle("Explore places near you")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//    VStack(alignment: .leading) {
//        Text("Featured Events")
//            .italic()
//            .padding(.leading)
//        ScrollView(.horizontal) {
//            HStack(spacing: 20) {
//                ForEach(0..<10) {
//                    Text("Item \($0)")
//                        .foregroundColor(.white)
//                        .font(.largeTitle)
//                        .frame(width: 280, height: 200)
//                        .background(.red)
//                }
//            }
//        }
//        .padding(.bottom)
//        .padding(.horizontal, 10)
//    }
