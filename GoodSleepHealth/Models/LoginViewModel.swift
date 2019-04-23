//
//  LoginViewModel.swift
//  GoodSleepHealth
//
//  Created by Azhar Mehmood on 4/15/19.
//  Copyright © 2019 Azhar Mehmood. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct UserInfo {
    static let userId = "userId"
    static let user = "userName"
    static let password = "password"
    static let userToken = "userToken"
    static let isLogin = "isLogin"
    static let loginTime = "loginTime"
    
}
class UserModel:NSObject {
    var id:String?
    var userName:String?
    var password:String?
    init(id:String,userName:String,password:String){
        self.id = id
        self.userName = userName
        self.password = password
    }
    func createUser(){
//        guard let appDelegate = UIApplication.shared as? AppDelegate else{return}
//        let manageContext = appDelegate.persistentContainer.viewContext
//        let userEntity = NSEntityDescription.entity(forEntityName: "User", in: manageContext)
//        let user = NSManagedObject(entity: userEntity!, insertInto: manageContext)
//        user.setValue("", forKey: UserInfo.userId)
    }
}

