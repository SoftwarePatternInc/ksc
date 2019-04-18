//
//  scheduleNotification.swift
//  GoodSleepHealth
//
//  Created by Azhar Mehmood on 4/16/19.
//  Copyright © 2019 Azhar Mehmood. All rights reserved.
//

import Foundation
import UserNotifications
class scheduleNotification {
    func scheduleNotification(notificationType: String,timeInterval:Date) {
        print("Notification will be triggered in 20 sec. Hold on...")
        let content = UNMutableNotificationContent() //
        content.title = notificationType
        content.body = "Alarm Setting " + notificationType + " Notifications"
        content.sound = UNNotificationSound.default
        content.badge = 0
       
       // let gregorian = Calendar(identifier: .iso8601)
        //let date = timeInterval
        let date = Date(timeIntervalSinceNow: 5) //timeInterval
//        let interval = timeInterval.timeIntervalSince(Date())
//        print(interval)
//        let date = Date(timeIntervalSinceNow: interval)
       // print(date)
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
      
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
        let request = UNNotificationRequest(identifier: notificationIdentifier.identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
            guard let errorDetail = error else {return}
            print(errorDetail)
            })
        
        
    }
}
