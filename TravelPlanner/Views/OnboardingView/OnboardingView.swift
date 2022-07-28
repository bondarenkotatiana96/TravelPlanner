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
            PageView(shouldShowOnboarding: $shouldShowOnboarding, text: "onboarding_1".localized(language), imageName: "page1", showsDismissButton: false)
            
            PageView(shouldShowOnboarding: $shouldShowOnboarding, text: "onboarding_2".localized(language), imageName: "page2", showsDismissButton: false)
            
            PageView(shouldShowOnboarding: $shouldShowOnboarding, text: "onboarding_3".localized(language), imageName: "page4", showsDismissButton: false)
            
            PageView(shouldShowOnboarding: $shouldShowOnboarding, text: "onboarding_4".localized(language), imageName: "page5", showsDismissButton: true)
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
