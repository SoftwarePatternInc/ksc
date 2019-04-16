//
//  WebViewController.swift
//  GoodSleepHealth
//
//  Created by Azhar Mehmood on 4/16/19.
//  Copyright © 2019 Azhar Mehmood. All rights reserved.
//

import Foundation
import SafariServices
class WebViewController: UIViewController,SFSafariViewControllerDelegate {
    override func viewDidLoad() {
        
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
