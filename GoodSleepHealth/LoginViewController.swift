//
//  ViewController.swift
//  GoodSleepHealth
//
//  Created by Azhar Mehmood on 4/15/19.
//  Copyright © 2019 Azhar Mehmood. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var resgisterButton: UIButton!
    @IBOutlet weak var forgotPassButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    var activityIndicator:UIActivityIndicatorView!
    // MARK:  ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        userEmailTextField.text = "sajid@spattern.com"
        passwordTextField.text = "123456"
        activityIndicator =  UIActivityIndicatorView(style: .gray)
        activityIndicator.center = view.center
        activityIndicator.isHidden = true
        self.view.addSubview(activityIndicator)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
       
    }
    override func viewDidDisappear(_ animated: Bool) {
        
        //super.viewDidDisappear(true)
//        print("disappera login View")
//        DispatchQueue.main.async {
//            self.dismiss(animated: true, completion: nil)
//        }
        
        
    }
    func documentInteractionControllerViewControllerForPreview(controller: UIDocumentInteractionController!) -> UIViewController! {
        return self
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    // MARK:  IBOutlet Action Methods
    @IBAction func termsButtonTap(_ sender: UIButton) {
        viewPdfFile(fileName: fileNames.termsFile)
        
    }
    @IBAction func privacyButtonTap(_ sender: UIButton) {
         viewPdfFile(fileName: fileNames.privacyFile)
    }
    
    @IBAction func disclaimerButtontap(_ sender: UIButton) {
         viewPdfFile(fileName: fileNames.disclaimerFile)
    }
    
    
    
    func displayActivityIndicatorView() -> () {
        DispatchQueue.main.async {
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.view.bringSubviewToFront(self.activityIndicator)
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        //self.activityIndicator.backgroundColor = .gray
        
            self.view.alpha = 0.4
        }
        
    }
    
    func hideActivityIndicatorView() -> () {
        if !self.activityIndicator.isHidden{
            DispatchQueue.main.async {
                UIApplication.shared.endIgnoringInteractionEvents()
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.view.alpha = 1
                
            }
        }
        
    }
    func handleLogin() {
        guard let email = userEmailTextField.text, let password = passwordTextField.text else {
            print("Form is not valid")
            return
        }
        //start activity indicator
        self.displayActivityIndicatorView()
        let webcall = userWebService()
        //webcall.loginUser((withEmail: email, password: password,c) { (user, error) in
       
            webcall.loginUser(withEmail: email, password: password, completionHandler: { (user) in
                guard let userL:UserJson = user as? UserJson else{
                    return
                }
                print(userL)
                if userL.status == "success" {
                    userDefaults.setValueWithBool(value: true, key: userDefaults.UserValues.login)
                    userDefaults.setValueWithBool(value: false, key: userDefaults.UserValues.intro)
                    self.performSegue(withIdentifier: segueIdentifier.LOGINTOHOME, sender: self)
                }
                else{
                    let alert =  Alert.showAert(title: "Error", message: "Username or Password is Invalid", buttonTitle: "Ok")
                    self.present(alert, animated: true, completion: nil)
                }
                self.hideActivityIndicatorView()
                // self.messagesController?.fetchUserAndSetupNavBarTitle()
                
                //self.dismiss(animated: true, completion: nil)
                
            })
        
    
        
        
    }
    func validateLogin(email:String,password:String) -> Bool {
        var isValid : Bool = false
        if email.isEmpty{
            userEmailTextField.becomeFirstResponder()
            return false
        }
        else if password.isEmpty{
            passwordTextField.becomeFirstResponder()
            return false
        }
        isValid = true
        return isValid
    }
    @IBAction func loginButtonTap(_ sender: UIButton) {
        if validateLogin(email: userEmailTextField.text!, password: passwordTextField.text!){
            if Connectivity.isConnectedToInternet{
                handleLogin()
            }
            else{
                let alert = Alert.showAert(title: "Error Connectivty", message: "Internet Connection is not available", buttonTitle: "Ok")
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
    }
    // MARK:  Delegate Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier.LOGINTOHOME{
            _ = segue.destination as! NavigationViewController
            
        }
    }
    
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

