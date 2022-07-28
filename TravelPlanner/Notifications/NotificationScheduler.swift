//
//  NotificationScheduler.swift
//  TravelPlanner
//
//  Created by Tatiana Bondarenko on 7/22/22.
//

import UserNotifications

class NotificationScheduler {
    func scheduleUserNotification(for trip: Trip) {

        let content = UNMutableNotificationContent()
        content.title = "Ready for your trip?"
        content.body = "You are going to \(trip.name) today!"
        content.sound = UNNotificationSound.default
        
        // Push notification at 8:30 in the morning on the trip day
        var fireDateComponents = Calendar.current.dateComponents(
            [.month, .day, .year], from: trip.dates[0])
        fireDateComponents.hour = 8
        fireDateComponents.minute = 30
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
    
    // For future: when I add notification settings
    func cancelUserNotification(for trip: Trip) {
        let id = "\(trip.id)"
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}
