//
//  SignInVC.swift
//  Iquue
//
//  Created by oskarGuest on 2017-07-23.
//  Copyright © 2017 oskarGuest. All rights reserved.
//

import UIKit
import UIKit
import CoreData
import Firebase
import FacebookLogin
import FacebookCore


class SignInVC: UIViewController {

    @IBOutlet weak var usernameOutlet: UITextFieldX!
    
    @IBOutlet weak var passwordOutlet: UITextFieldX!
    @IBOutlet weak var greenMail: UIButtonX!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        usernameOutlet.alpha = 0
        passwordOutlet.alpha = 0
        greenMail.alpha = 0
        greenMail.shadowOpacity = 0
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func facebookLoginBtnPress(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
                self.firebaseAuth(credential)
                
            }
        }
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (user, error) in
            if (error != nil) {
                print("Unable to sign in with firebase")
            } else {
                print("Sucessful sign in with firebase")
            }
        }
    }

    

    @IBAction func showMeEmail(_ sender: Any) {
       
        usernameOutlet.alpha = 0.75
        passwordOutlet.alpha = 0.75
        greenMail.alpha = 1
    }
 
    @IBAction func emailButton(_ sender: Any) {
    }

   /* @IBAction func faceBook(_ sender: Any) {
    }*/
}
