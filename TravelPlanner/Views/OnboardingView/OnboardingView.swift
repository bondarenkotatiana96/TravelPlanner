//
//  OnboardingView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/25/22.
//

import SwiftUI

struct OnboardingView: View {
    
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    @Binding var shouldShowOnboarding: Bool
    
    var body: some View {
        TabView {
            PageView(text: "onboarding_1".localized(language), imageName: "page1", showsDismissButton: false, shouldShowOnboarding: $shouldShowOnboarding)
            
            PageView(text: "onboarding_2".localized(language), imageName: "page2", showsDismissButton: false, shouldShowOnboarding: $shouldShowOnboarding)
            
            PageView(text: "onboarding_3".localized(language), imageName: "page4", showsDismissButton: false, shouldShowOnboarding: $shouldShowOnboarding)
            
            PageView(text: "onboarding_4".localized(language), imageName: "page5", showsDismissButton: true, shouldShowOnboarding: $shouldShowOnboarding)
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
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
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
                    Text("skip".localized(language))
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
                        ButtonLabel(text: "start_button".localized(language), imageName: "", width: 200, height: 50, imageSize: 0)
                    }
                }
            }
        }
    }
}
