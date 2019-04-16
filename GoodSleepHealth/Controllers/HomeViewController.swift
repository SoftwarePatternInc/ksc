//
//  HomeViewController.swift
//  GoodSleepHealth
//
//  Created by Azhar Mehmood on 4/15/19.
//  Copyright © 2019 Azhar Mehmood. All rights reserved.
//

import Foundation
import UIKit
import SafariServices
import UserNotifications
class HomeViewController: UIViewController,SFSafariViewControllerDelegate {
    var data:String?
    override func viewDidLoad() {
//        guard let cData = data else{
//            return
//        }
//
//        print(cData)
       // let notify = scheduleNotification()
        //notify.scheduleNotification(notificationType: "Good")
    }
    @IBAction func settingTap(_ sender: UIButton) {
        performSegue(withIdentifier: segueIdentifier.SETTINGALARM, sender: self)
    }
    
    @IBAction func introductionButtonTap(_ sender: UIButton) {
        CommonUtil.webViewUrl = "https://www.goodsleephealth.ca/insomnia/insomnia_overview_2"
        loadWebUrl()
    }
    @IBAction func privacyButtontap(_ sender: UIButton) {
        CommonUtil.webViewUrl = "https://www.goodsleephealth.ca/content/privacy"
        loadWebUrl()
    }
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    func loadWebUrl() {
        let safariVc = SFSafariViewController(url: NSURL(string: CommonUtil.webViewUrl)! as URL)
        self.present(safariVc, animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier.SETTINGALARM{
            if let vc = segue.destination as? AlaramSettingViewController {
                print(vc.isViewLoaded)
            }
            
        }
        if segue.identifier == "navigation"{
            if let vc = segue.destination as? WebViewController {
                print(vc.isViewLoaded)
            }
        }
    }
}
