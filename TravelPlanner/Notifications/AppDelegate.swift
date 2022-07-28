//
//  AppDelegate.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/22/22.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {
          (accepted, error) in
          if !accepted {
            print("Notification access has been denied")
          }
        }
        UNUserNotificationCenter.current().delegate = self
        return true
    }
}

