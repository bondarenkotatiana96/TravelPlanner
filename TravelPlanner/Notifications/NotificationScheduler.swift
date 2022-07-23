//
//  NotificationScheduler.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/22/22.
//

import Foundation
import UserNotifications

class NotificationScheduler {
    func scheduleUserNotification(for trip: Trip) {

        let content = UNMutableNotificationContent()
        content.title = "Ready for your trip?"
        content.body = "You are going to \(trip.name) today!"
        content.sound = UNNotificationSound.default

        var fireDateComponents = Calendar.current.dateComponents(
            [.month, .day, .year], from: trip.dates[0])
        fireDateComponents.hour = 18
        fireDateComponents.minute = 16
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDateComponents, repeats: false)
        let request = UNNotificationRequest(
            identifier: "\(trip.id)", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
          if let error = error {
            print(
              "Error scheduling local user notifications \(error.localizedDescription)  :  \(error)")
          }
        }
    }
    
    func cancelUserNotification(for trip: Trip) {
        let id = "\(trip.id)"
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}
