//
//  ViewController.swift
//  Hack2018
//
//  Created by Charles-Olivier Demers on 2018-01-20.
//  Copyright © 2018 Charles-Olivier Demers. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        kWidth = self.view.frame.width
        kHeight = self.view.frame.height
        
        let loginButton = FBSDKLoginButton()
        loginButton.center = self.view.center
        loginButton.readPermissions = ["public_profile", "email", "user_friends", "user_about_me"]
        loginButton.delegate = self
        self.view.addSubview(loginButton)
        
        fetchUserInfo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        fetchUserInfo()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logout")
    }

    func fetchUserInfo() {
        if(FBSDKAccessToken.current() != nil) {
            print("USer is logged")
            
            let fbRequest = FBSDKGraphRequest.init(graphPath: "me?fields=id,name,email,friends", parameters: nil)
            fbRequest!.start(completionHandler: { (_: FBSDKGraphRequestConnection?, result: Any?, error: Error?) in
                
                if error != nil {
                    print("Error")
                    print(error!)
                    
                    displayAlert(viewController: self, title: "Erreur", message: "Fetching user info - 01")
                } else if (result != nil) {
                    //  NOM
                    //  PHOTO
                    //  FRIENDS
                    //  ID
                    //  EMAIL
                    
                    print(result!)
                }
                
            })
        }
        
    }
}

