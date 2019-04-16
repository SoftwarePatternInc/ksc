//
//  CommonUtil.swift
//  GoodSleepHealth
//
//  Created by Azhar Mehmood on 4/15/19.
//  Copyright © 2019 Azhar Mehmood. All rights reserved.
//

import Foundation
struct segueIdentifier {
    static let LOGINTOHOME = "LOGINTOHOME"
    static let SETTINGALARM = "SETTINGALARM"
}
class CommonUtil: NSObject {
    static var webViewUrl = ""
    static var morningAlarm:Date?
    static var eveningAlaram:Date?
}
