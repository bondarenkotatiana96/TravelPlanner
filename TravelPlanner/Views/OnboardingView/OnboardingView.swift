//
//  OnboardingView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/25/22.
//

import SwiftUI

struct OnboardingView: View {
    
    @Binding var shouldShowOnboarding: Bool
    
    var body: some View {
        TabView {
            PageView(text: "Search for destinations, add them to the list and change trip details", imageName: "page1", showsDismissButton: false, shouldShowOnboarding: $shouldShowOnboarding)
            
            PageView(text: "Look up places to visit and pin them on the map", imageName: "page2", showsDismissButton: false, shouldShowOnboarding: $shouldShowOnboarding)
            
            PageView(text: "Explore the most popular destinations and local places", imageName: "page4", showsDismissButton: false, shouldShowOnboarding: $shouldShowOnboarding)
            
            PageView(text: "Enjoy your trip and don't worry about forgetting anything", imageName: "page5", showsDismissButton: true, shouldShowOnboarding: $shouldShowOnboarding)
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle())
        .onAppear {
            setupAppearance()
        }
    }
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(red: 1.00, green: 0.71, blue: 0.54, alpha: 1.00)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.2)
      }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(shouldShowOnboarding: .constant(true))
    }
}

struct PageView: View {
    var text: String
    var imageName: String
    let showsDismissButton: Bool
    @Binding var shouldShowOnboarding: Bool
    
    var body: some View {
        ZStack {
            Image(imageName)
                .ignoresSafeArea()
                .overlay(Color.black.opacity(0.4))
            VStack {
                Button {
                    shouldShowOnboarding.toggle()
                } label: {
                    Text("Skip")
                }
                .offset(x: 150, y: -200)
                
                Text(text)
                    .font(.system(size: 17))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 30)
                    .background(RoundedRectangle(cornerRadius: 15).fill(Color("AccentColor").opacity(0.3)))
                    .frame(width: UIScreen.main.bounds.width - 50)
                
                if showsDismissButton {
                    Button {
                        shouldShowOnboarding.toggle()
                    } label: {
                        ButtonLabel(text: "Get Started", imageName: "", width: 200, height: 50, imageSize: 0)
                    }
                }
            }
        }
    }
}
