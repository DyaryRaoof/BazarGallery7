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

class ViewController: UIViewController {
    @IBOutlet weak var facebookButton: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facebookButton.layer.cornerRadius = 20
        loginButton.layer.cornerRadius = 20
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                
            case .cancelled:
                print ("Cancelled")
                SVProgressHUD.show(withStatus: "Cancelled")
                SVProgressHUD.dismiss(withDelay: 1)
            }
        }
        
        func signIntoFirebase(){
            
          
            
            guard let authenticationToken = AccessToken.current?.authenticationToken else {return }
            let credential = FacebookAuthProvider.credential(withAccessToken: authenticationToken)
            Auth.auth().signIn(with: credential) { (user, error) in
                
                if let error = error {
                    print(error)
                    return
                }
               print ("Successfully Logged Into Facebook")
                SVProgressHUD.dismiss()
                
            }
        }
        
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
    }
    
}

