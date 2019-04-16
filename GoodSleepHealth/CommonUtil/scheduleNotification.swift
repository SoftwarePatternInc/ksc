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
        let content = UNMutableNotificationContent() //
        content.title = notificationType
        content.body = "This is example how to create " + notificationType + " Notifications"
        content.sound = UNNotificationSound.default
        content.badge = 0
        let identifier = "Local Notification"
        //let
        let date = timeInterval //Date(timeIntervalSinceNow: 1)
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
            guard let errorDetail = error else {return}
            print(errorDetail)
            })
        
        
    }
}
