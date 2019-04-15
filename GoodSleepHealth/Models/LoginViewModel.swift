//
//  LoginViewModel.swift
//  GoodSleepHealth
//
//  Created by Azhar Mehmood on 4/15/19.
//  Copyright © 2019 Azhar Mehmood. All rights reserved.
//

import Foundation
class UserModel:NSObject {
    var id:String?
    var userName:String?
    var password:String?
    init(id:String,userName:String,password:String){
        self.id = id
        self.userName = userName
        self.password = password
    }
}

