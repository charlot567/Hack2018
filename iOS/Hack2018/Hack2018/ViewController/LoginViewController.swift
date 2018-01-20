//
//  LoginViewController.swift
//  Hack2018
//
//  Created by CharlesOlivier Demers on 18-01-20.
//  Copyright © 2018 Charles-Olivier Demers. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import VideoSplashKit

class LoginViewController: VideoSplashViewController, FBSDKLoginButtonDelegate {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        kWidth = self.view.frame.width
        kHeight = self.view.frame.height
        
        let loginButton = FBSDKLoginButton()
        loginButton.center = self.view.center
        loginButton.readPermissions = ["public_profile", "email", "user_friends", "user_about_me"]
        loginButton.delegate = self
        self.view.addSubview(loginButton)
        
        fetchUserInfo()
        
        if let path = Bundle.main.path(forResource: "login_video", ofType: "mp4") {
            let url = URL(fileURLWithPath: path)
            videoFrame = view.frame
            fillMode = .resizeAspectFill
            alwaysRepeat = true
            sound = true
            startTime = 12.0
            duration = 4.0
            alpha = 0.7
            backgroundColor = UIColor.black
            contentURL = url
        }
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
