//
//  AlaramSettingViewController.swift
//  GoodSleepHealth
//
//  Created by Azhar Mehmood on 4/15/19.
//  Copyright © 2019 Azhar Mehmood. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import AudioToolbox
import EventKit
class AlaramSettingViewController: UIViewController,UNUserNotificationCenterDelegate {
    
    
    @IBOutlet weak var morningAlarmPicker: UIDatePicker!
    @IBOutlet weak var eveningAlarmPicker: UIDatePicker!
    //var eventStore = EKEventStore()
    override func viewDidLoad() {
        super.viewDidLoad()
//        sender.timeZone = Calendar.current.timeZone
//        sender.locale = Calendar.current.locale
        
        UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
        morningAlarmPicker.timeZone = Calendar.current.timeZone
        morningAlarmPicker.locale =  Calendar.current.locale
        let s =  SystemSoundID(integerLiteral: 1304)
        AudioServicesPlayAlertSound(s)
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Tapped in notification")
    }
    
    //This is key callback to present notification while the app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("Notification being triggered")
        //You can either present alert ,sound or increase badge while the app is in foreground too with ios 10
        //to distinguish between notifications
        if notification.request.identifier == notificationIdentifier.identifier{
            
            completionHandler( [.alert,.sound,.badge])
            
        }
    }
    func AddReminder(title:String,notes:String,timeDate:Date) {
        let eventStore = EKEventStore()
        eventStore.requestAccess(
            to: EKEntityType.event, completion: {(granted, error) in
                if !granted {
                    print("Access to store not granted")
                    print(error!.localizedDescription)
                } else {
                    print("Access granted")
                    eventStore.requestAccess(to: EKEntityType.reminder, completion: {
                        granted, error in
                        if (granted) && (error == nil) {
                            print("granted \(granted)")
                            
                            
                            let reminder:EKReminder = EKReminder(eventStore: eventStore)
                            reminder.title = title
                            reminder.priority = 1
                            
                            //  How to show completed
                            //reminder.completionDate = Date()
                            
                            reminder.notes = notes
                            
                            
                            let alarmTime = timeDate
                            print("\(title)\(alarmTime)")
                            let alarm = EKAlarm(absoluteDate: alarmTime)
                            reminder.addAlarm(alarm)
                            
                            reminder.calendar = eventStore.defaultCalendarForNewReminders()
                            
                            
                            do {
                                try eventStore.save(reminder, commit: true)
                            } catch {
                                print("Cannot save")
                                return
                            }
                            print("Reminder saved")
                        }
                    })
                }
        })

        
    }
    @IBAction func morningPickerTap(_ sender: UIDatePicker) {
        //print(sender.date)
        getTime(sender: sender,morning: true)
//        let date = sender.date
//        let strTime = date.dateStringWith(strFormat: "yyyy/MM/dd hh:mm a")
//        print(strTime)
    }
    @IBAction func eveningPickerTap(_ sender: UIDatePicker) {
        getTime(sender: sender,morning: false)
    }
    
    @IBAction func saveButtonTap(_ sender: UIButton) {
         //let notify = scheduleNotification()
        guard let morningTimeInterval = CommonUtil.morningAlarm else {
            return
        }
        guard let eveningTimeInterval = CommonUtil.eveningAlaram else {
            return
        }
        AddReminder(title: "Morning", notes: "Open Good Sleep Health and Fill Morning Questionair", timeDate: morningTimeInterval)
        AddReminder(title: "Evening", notes: "Open Good Sleep Health and Fill Evening Questionair", timeDate: eveningTimeInterval)
        
//        notify.scheduleNotification(notificationType: "Morning Alaram", timeInterval: morningTimeInterval)
//        notify.scheduleNotification(notificationType: "Evening Alaram", timeInterval: eveningTimeInterval)
        
    }
    
    func getTime(sender:UIDatePicker,morning:Bool)
    {
        let outputTimeInterval = sender.date
        //print("Phone Date :\(Date()) .. Picker Date \(outputTimeInterval)")
        
        if morning{
            CommonUtil.morningAlarm = outputTimeInterval
        }
        else{
            CommonUtil.eveningAlaram = outputTimeInterval
        }
        //print("ouptputTime: \(outputTimeInterval)")
    }
    func parseDuration(_ timeString:String) -> TimeInterval {
        guard !timeString.isEmpty else {
            return 0
        }
        var interval:Double = 0
        let parts = timeString.components(separatedBy: ":")
        for (index, part) in parts.reversed().enumerated() {
            interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
        }
        return interval
    }
    
}
