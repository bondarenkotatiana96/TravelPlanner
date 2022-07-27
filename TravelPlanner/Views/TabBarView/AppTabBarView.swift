//
//  AppTabBarView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/13/22.
//

import SwiftUI

struct AppTabBarView: View {
    
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
    @AppStorage("shouldShowOnboarding") var shouldShowOnboarding: Bool = true
    
    @State private var selection = 1
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "UnselectedTabColor")
      }
    
    var body: some View {
        TabView(selection:$selection) {
            HomeView()
                .tabItem {
                    Label("tab_explore".localized(language), systemImage: "globe.europe.africa.fill")
                }
                .tag(3)
            TripListView()
                .tabItem {
                    Label("tab_trips".localized(language), systemImage: "map.circle.fill")
                }
                .tag(2)
            UserProfileView(shouldShowOnboarding: _shouldShowOnboarding)
                .tabItem {
                    Label("tab_profile".localized(language), systemImage: "person.circle.fill")
                }
                .tag(1)
        }
        .fullScreenCover(isPresented: $shouldShowOnboarding, content: {
            OnboardingView(shouldShowOnboarding: $shouldShowOnboarding)
        })
    }
}

struct AppTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabBarView()
    }
}
