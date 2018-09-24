//
//  regsitrationViewController.swift
//  BazarGallery7
//
//  Created by Dyary Raoof Bayz on 9/24/18.
//  Copyright © 2018 Dyary Raoof Bayz. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class registrationViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registrationButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       emailTextField.layer.cornerRadius = 20
        passwordTextField.layer.cornerRadius = 20
        registrationButton.layer.cornerRadius = 20
    }


    @IBAction func registrationButtonPressed(_ sender: UIButton) {
        
        SVProgressHUD.show()
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil{
                print(error)
            }else{
                print ("Registration Successful")
                
                SVProgressHUD.dismiss(withDelay: 1)
                
                self.performSegue(withIdentifier: "goBackToMainView", sender: self)
            }
        }
    }
}
    

