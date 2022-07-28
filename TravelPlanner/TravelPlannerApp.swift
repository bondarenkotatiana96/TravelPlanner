//
//  TravelPlannerApp.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/11/22.
//

import SwiftUI

@main
struct TravelPlannerApp: App {
    // Delegate for local push notifications
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            AppTabBarView()
        }
    }
}
