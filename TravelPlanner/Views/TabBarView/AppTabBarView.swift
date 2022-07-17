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
        UITabBar.appearance().backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)
      }
    
    var body: some View {
        TabView(selection:$selection) {
            TripListView()
                .tabItem {
                    Label("My Trips", systemImage: "map.circle.fill")
                }
                .tag(1)
            UserProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle.fill")
                }
                .tag(2)
        }
        .accentColor(Color(red: 1, green: 0.71, blue: 0.541))
    }
}

struct AppTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabBarView()
    }
}
