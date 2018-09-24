//
//  ViewController.swift
//  BazarGallery7
//
//  Created by Dyary Raoof Bayz on 9/24/18.
//  Copyright © 2018 Dyary Raoof Bayz. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import FacebookCore
import FacebookLogin
import FirebaseAuth

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var mainViewUnderScrollView: UIView!
    
    
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facebookButton.layer.cornerRadius = 20
        loginButton.layer.cornerRadius = 20
        emailTextField.layer.cornerRadius = 15
        passwordTextField.layer.cornerRadius = 15
        
        
        emailTextField.delegate  = self
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        mainScrollView.contentOffset = CGPoint(x: 0, y: 140)
    }
    
    
    
    @IBAction func facebookButotnPressed(_ sender: UIButton) {
        
        
        
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email], viewController: self) { (result) in
            
            switch result {
            case .success(grantedPermissions: _, declinedPermissions: _, token: _):
                
                  SVProgressHUD.show()
                  
                  signIntoFirebase()
                
            case .failed( let error):
                print(error)
                SVProgressHUD.showError(withStatus: "كێشه‌یه‌ك ڕوویدا")
                SVProgressHUD.dismiss(withDelay: 1)
                
            case .cancelled:
                print ("Cancelled")
                SVProgressHUD.show(withStatus: "ڕه‌تكرایه‌وه‌")
                SVProgressHUD.dismiss(withDelay: 1)
                
            }
        }
        
        func signIntoFirebase(){
            
          
            
            guard let authenticationToken = AccessToken.current?.authenticationToken else {return }
            let credential = FacebookAuthProvider.credential(withAccessToken: authenticationToken)
            Auth.auth().signIn(with: credential) { (user, error) in
                
                if let error = error {
                    print(error)
                    SVProgressHUD.showError(withStatus: "كێشه‌یه‌ك ڕوویدا")
                    return
                }
                SVProgressHUD.dismiss()
                
                
                print ("Successfully Logged Into Facebook")
                
                self.performSegue(withIdentifier: "goToMainCategoryView", sender: self)
                
               SVProgressHUD.showSuccess(withStatus: "سه‌ركه‌وتوو بوو !")
                SVProgressHUD.dismiss(withDelay: 1)
                
                
            }
        }
        
    }
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                print(error)
                SVProgressHUD.showError(withStatus: "كێشه‌یه‌ك ڕوویدا")
                SVProgressHUD.dismiss(withDelay: 1)
            }else {
                SVProgressHUD.dismiss()
                SVProgressHUD.showSuccess(withStatus: "سه‌ركه‌هوتوو بوو")
                SVProgressHUD.dismiss(withDelay: 1)
                
                print("Log in Successful")
                self.performSegue(withIdentifier: "goToMainCategoryView", sender: self)
            }
        }
    }
    
}

