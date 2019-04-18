//
//  usersWebService.swift
//  GoodSleepHealth
//
//  Created by Azhar Mehmood on 4/15/19.
//  Copyright © 2019 Azhar Mehmood. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
typealias Codable = Decodable & Encodable
struct UserJson: Codable {
    //let email:String?
    //let password:String?
    let status:String?
    let auth_token:String?
    private enum CodingKeys: String, CodingKey {
       // case email
       // case password
        case status = "status"
        case auth_token = "auth_token"
    }
}
class userWebService: NSObject {
    
    func loginUser(withEmail:String,password:String, completionHandler : @escaping (Codable)->Void){
        
        guard let url = URL(string: "https://goodsleephealth.ca/auth_service.php") else {
            return
        }
        let user1 = withEmail
        let pass = password
        print(user1)
        print(pass)
        let data : Data = "email=\(user1)&password=\(pass)".data(using: .utf8)!
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type");
        request.setValue(NSLocalizedString("lang", comment: ""), forHTTPHeaderField:"Accept-Language");
        request.httpBody = data
        
        print("one called")
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
            let task = session.dataTask(with: request, completionHandler: {
                (data, response, error) in
                
                if let error = error
                {
                    print(error)
                }
                else if response != nil {
                    print("her in resposne")
                    
                }else if let data = data
                {
                    print("here in data")
                    print(data)
                }
                
                //DispatchQueue.main.async { // Correct
                
                guard let responseData = data else {
                    print("Error: did not receive data")
                    return
                }
                
                let decoder = JSONDecoder()
                print(String(data: responseData, encoding: .utf8)!)
                do {
                    let todo = try decoder.decode(UserJson.self, from: responseData)
                    if todo.status == "success"{
                        print(todo.status!)
                        completionHandler(todo)
                    }
                    else{
                        completionHandler(todo)
                    }
                    
                    // NSAssertionHandler(.success(todo))
                } catch {
                    print("error trying to convert data to JSON")
                    print(error)
                    // NSAssertionHandler(.failure(error))
                }
                //}
            })
            task.resume()

        
        
        
        
        
    }
    }

