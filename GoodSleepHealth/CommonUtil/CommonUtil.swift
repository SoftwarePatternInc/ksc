//
//  CommonUtil.swift
//  GoodSleepHealth
//
//  Created by Azhar Mehmood on 4/15/19.
//  Copyright © 2019 Azhar Mehmood. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
struct notificationIdentifier {
   static let identifier = UUID().uuidString
}
struct fileNames {
    static let privacyFile = "Privacy Statement"
    static let introductionFile = "Insomnia Introduction"
    static let termsFile = "Terms of Use Agreement"
    static let disclaimerFile = "DISCLAIMER"
    
}
struct segueIdentifier {
    static let LOGINTOHOME = "LOGINTOHOME"
    static let SETTINGALARM = "SETTINGALARM"
}
class CommonUtil: NSObject {
    static var webViewUrl = ""
    static var morningAlarm:Date?
    static var eveningAlaram:Date?
}
class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
class Alert {
   static func showAert(title:String,message:String,buttonTitle:String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        //self.present(alert, animated: true)
        return alert
    }
}
class userDefaults{
    struct UserValues {
        static let login = "login"
        static let intro = "intro"
    }
   static func setValueWithBool(value:Bool,key:String){
        UserDefaults.standard.set(value, forKey: key)
    }
   static func getValueWithBool(key:String)->Bool{
        let status = UserDefaults.standard.bool(forKey: key)
        return status
    }
    
}
extension Date {
    
    func dateToString() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.string(from: self) //.string(from: self)
    }
    
}
extension String{
    func stringToDate() -> Date {
        let dateFormatter = DateFormatter()
       
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
         let date = dateFormatter.date(from: self)
        
        return date!
    }

}
