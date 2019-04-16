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
class HomeViewController: UIViewController,SFSafariViewControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return items.count
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == weeksCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weeksCell", for: indexPath as IndexPath) as! WeekCollectionViewCell
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.weekNumber.text = "Week" + self.items[indexPath.item]
            cell.backgroundColor = UIColor.gray // make cell more visible in our example project
            
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DaysCell", for: indexPath as IndexPath) as! DaysCollectionViewCell
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            cell.dayNumber.text = "Day" + self.items[indexPath.item]
            cell.backgroundColor = UIColor.darkGray // make cell more visible in our example project
            
            return cell
        }
        
    }
    
    var data:String?
    
    @IBOutlet weak var weeksCollectionView: UICollectionView!
    @IBOutlet weak var daysCollectionView: UICollectionView!
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

    override func viewDidLoad() {
        super.viewDidLoad()
        weeksCollectionView.delegate = self
        daysCollectionView.delegate = self
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
