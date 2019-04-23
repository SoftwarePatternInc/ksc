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
import PDFKit

extension UIViewController:UIDocumentInteractionControllerDelegate{
    func viewPdfFile(fileName: String) {
        let fileURL = Bundle.main.url(forResource: fileName, withExtension: "pdf")
        let dc = UIDocumentInteractionController(url: fileURL!)
        dc.delegate = self
        dc.presentPreview(animated: true)
    }
}
class HomeViewController: UIViewController,SFSafariViewControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate {
    
    
    
    var data:String?
    
    @IBOutlet weak var weeksCollectionView: UICollectionView!
    @IBOutlet weak var daysCollectionView: UICollectionView!
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

    override func viewDidLoad() {
        super.viewDidLoad()
        weeksCollectionView.delegate = self
        daysCollectionView.delegate = self
        isLogin()
        
    }
    override func viewWillAppear(_ animated: Bool) {
       
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    //MARK: UIDocumentInteractionController delegates
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self//or use return self.navigationController for fetching app navigation bar colour
    }
    @IBAction func settingTap(_ sender: UIButton) {
        performSegue(withIdentifier: segueIdentifier.SETTINGALARM, sender: self)
    }
    
    @IBAction func disclaimerButtonTap(_ sender: UIButton) {
        viewPdfFile(fileName: fileNames.disclaimerFile)
    }
    @IBAction func termsButtonTap(_ sender: UIButton) {
        viewPdfFile(fileName: fileNames.termsFile)
    }
    @IBAction func introductionButtonTap(_ sender: UIButton) {
        viewPdfFile(fileName: fileNames.introductionFile)
    }
    @IBAction func privacyButtontap(_ sender: UIButton) {
        
       viewPdfFile(fileName: fileNames.privacyFile)
    }
    
    @IBAction func logoutTap(_ sender: UIBarButtonItem) {
        print("Logout")
        let loginViewController = storyboard?.instantiateViewController(withIdentifier: "Startpage")
        userDefaults.setValueWithBool(value: false, key: userDefaults.UserValues.login)
        userDefaults.setValueWithBool(value: false, key: userDefaults.UserValues.intro)
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
            self.present(loginViewController!, animated: true, completion: nil)
        }
    }
    
    func isIntroShow(){
        if !userDefaults.getValueWithBool(key: userDefaults.UserValues.intro){
              userDefaults.setValueWithBool(value: true, key: userDefaults.UserValues.intro)
            viewPdfFile(fileName: fileNames.introductionFile)
        }
    }
    func  isLogin() {
       
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Startpage")
        
        if !userDefaults.getValueWithBool(key: userDefaults.UserValues.login){
            DispatchQueue.main.async {
                self.present(loginViewController!, animated: true, completion: nil)
            }
            
        }
        else{
            isIntroShow()
        }
        
            
        
    }
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    func loadWebUrl() {
        DispatchQueue.main.async {
        //let safariVc = SFSafariViewController(url: NSURL(string: CommonUtil.webViewUrl)! as URL)
        print(CommonUtil.webViewUrl)
            //safariVc.delegate = self
        
        //self.present(safariVc, animated: true, completion: nil)
            guard let url = URL(string: CommonUtil.webViewUrl) else { return }
            UIApplication.shared.open(url)
        }
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return items.count
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
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
   /*   func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let indexPath = weeksCollectionView.indexPathForItem(at: weeksCollectionView.center)
        weeksCollectionView.scrollToItem(at: indexPath!, at: .centeredHorizontally, animated: true)
    }*/
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    
        if scrollView == weeksCollectionView{

            var closestCell : UICollectionViewCell = weeksCollectionView.visibleCells.first!
            for cell in weeksCollectionView!.visibleCells as [UICollectionViewCell] {
                let closestCellDelta = abs(closestCell.center.x - weeksCollectionView.bounds.size.width/2.0 - weeksCollectionView.contentOffset.x)
                let cellDelta = abs(cell.center.x - weeksCollectionView.bounds.size.width/2.0 - weeksCollectionView.contentOffset.x)
                if (cellDelta < closestCellDelta){
                    closestCell = cell
                }
            }
            let indexPath = weeksCollectionView.indexPath(for: closestCell)
            weeksCollectionView.scrollToItem(at: indexPath!, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        }
        else{
            var closestCell : UICollectionViewCell = daysCollectionView.visibleCells.first!
            for cell in daysCollectionView!.visibleCells as [UICollectionViewCell] {
                let closestCellDelta = abs(closestCell.center.x - daysCollectionView.bounds.size.width/2.0 - daysCollectionView.contentOffset.x)
                let cellDelta = abs(cell.center.x - daysCollectionView.bounds.size.width/2.0 - daysCollectionView.contentOffset.x)
                if (cellDelta < closestCellDelta){
                    closestCell = cell
                }
            }
            let indexPath = daysCollectionView.indexPath(for: closestCell)
            daysCollectionView.scrollToItem(at: indexPath!, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
    }
    }
    
    
    
}
