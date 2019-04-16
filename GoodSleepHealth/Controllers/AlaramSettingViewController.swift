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
class AlaramSettingViewController: UIViewController,UIPickerViewDelegate {
    
    
    @IBOutlet weak var morningAlarmPicker: UIDatePicker!
    @IBOutlet weak var eveningAlarmPicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        morningAlarmPicker.timeZone = TimeZone(secondsFromGMT: 5*60*60)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBAction func morningPickerTap(_ sender: UIDatePicker) {
        getTime(sender: sender,morning: true)
    }
    @IBAction func eveningPickerTap(_ sender: UIDatePicker) {
        getTime(sender: sender,morning: false)
    }
    
    @IBAction func saveButtonTap(_ sender: UIButton) {
         let notify = scheduleNotification()
        guard let morningTimeInterval = CommonUtil.morningAlarm else {
            return
        }
        guard let eveningTimeInterval = CommonUtil.eveningAlaram else {
            return
        }
        notify.scheduleNotification(notificationType: "Morning Alaram", timeInterval: morningTimeInterval)
        notify.scheduleNotification(notificationType: "Evening Alaram", timeInterval: eveningTimeInterval)
        
    }
    func getTime(sender:UIDatePicker,morning:Bool)
    {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "hh:mm:ss a"
        let outputTimeInterval = sender.date
        
        if morning{
            CommonUtil.morningAlarm = outputTimeInterval
        }
        else{
            CommonUtil.eveningAlaram = outputTimeInterval
        }
        print("ouptputTime: \(outputTimeInterval)")
        //print(parseDuration(ouptputTime))
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
