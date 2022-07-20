//
//  AppTabBarView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/13/22.
//

import SwiftUI

struct AppTabBarView: View {
    
    @State private var selection = 1
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
      }
    
    var body: some View {
        TabView(selection:$selection) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.circle.fill")
                }
                .tag(1)
            TripListView()
                .tabItem {
                    Label("My Trips", systemImage: "map.circle.fill")
                }
                .tag(2)
            UserProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle.fill")
                }
                .tag(3)
        }
    }
}

struct AppTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabBarView()
    }
}
