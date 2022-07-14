//
//  AppTabBarView.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/13/22.
//

import SwiftUI

struct AppTabBarView: View {
    
    @State private var selection = 2
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.secondaryLabel
      }
    
    var body: some View {
        TabView(selection:$selection) {
            TripListView()
                .tabItem {
                    Image(systemName: selection == 1 ? "house" : "person")
                }
                .tag(1)
            UserProfileView()
                .tabItem {
                    Image(systemName: selection == 2 ? "person" : "house")
                }
                .tag(2)
        }
    }
}

struct AppTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabBarView()
    }
}
