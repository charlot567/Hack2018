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
import SwiftSpinner

class LoginViewController: VideoSplashViewController, FBSDKLoginButtonDelegate {
    
    private let loginLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kWidth = self.view.frame.width
        kHeight = self.view.frame.height
        IPHONE_X = kHeight == 812
        
        let loginButton = FBSDKLoginButton()
        loginButton.center = self.view.center
        loginButton.readPermissions = ["public_profile", "email", "user_friends", "user_about_me"]
        loginButton.delegate = self
        
        setupView()
        
        self.fetchUserInfo { (succes: Bool, user: User?) in
            
            self.loginResult(success: succes, user: user)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func setupView() {
        
        if let path = Bundle.main.path(forResource: "login_video", ofType: "mp4") {
            let url = URL(fileURLWithPath: path)
            videoFrame = view.frame
            fillMode = .resizeAspectFill
            alwaysRepeat = true
            sound = false
            startTime = 0
            alpha = 0.6
            backgroundColor = UIColor.black
            contentURL = url
        }
        
        let y: CGFloat = 150.0
        let title = UILabel()
        title.frame = CGRect(x: 0, y: y, width: kWidth, height: 100)
        title.text = "NAO".lz()
        title.textColor = .white
        title.textAlignment = .center
        title.font = UIFont(name: "Arial", size: 50)
        title.sizeToFit()
        title.frame = CGRect(x: self.view.frame.width / 2 - title.frame.width / 2, y: title.frame.origin.y, width: title.frame.width, height: title.frame.height)
        self.view.addSubview(title)
        
        let tempSpacing: CGFloat = 20
        let line = UIView()
        line.frame = CGRect(x: title.frame.origin.x - tempSpacing / 2, y: title.frame.maxY + 5, width: title.frame.width + tempSpacing, height: 1)
        line.backgroundColor = .white
        self.view.addSubview(line)
        
        let buttonHeight: CGFloat = 100
        
        let buttonView = UIButton()
        buttonView.frame = CGRect(x: 0, y: kHeight - buttonHeight, width: kWidth, height: buttonHeight)
        buttonView.addTarget(self, action: #selector(login), for: .touchUpInside)
        buttonView.backgroundColor = UIColor(red: 42 / 255, green: 93 / 255, blue: 149 / 255, alpha: 1)
        self.view.addSubview(buttonView)
        
        loginLabel.frame = CGRect(x: 0, y: 0, width: kWidth, height: buttonHeight)
        loginLabel.textColor = .white
        loginLabel.textAlignment = .center
        loginLabel.font = UIFont(name: "Arial", size: 20)
        buttonView.addSubview(loginLabel)
        
        updateLoginLabel()
        
    }
    
    @objc
    func login() {
        
        let loginManager = FBSDKLoginManager()
        
        if(FBSDKAccessToken.current() != nil) {
            loginManager.logOut()
            updateLoginLabel()
        } else {
            loginManager.logIn(withReadPermissions:  ["public_profile", "email", "user_friends", "user_about_me"], from: nil) { (loginResult: FBSDKLoginManagerLoginResult?, error: Error?) in
                
                if(error != nil) {
                    displayAlert(viewController: self, title: "Error", message: "Facebook Login - 02")
                    return
                }
                
                self.updateLoginLabel()
                self.fetchUserInfo { (succes: Bool, user: User?) in
                    
                    self.loginResult(success: succes, user: user)
                }
            }
        }
    }
    
    private func updateLoginLabel() {
        let label: String = FBSDKAccessToken.current() != nil ? "DISCONNECT_FB".lz() : "LOGIN_FB".lz()
        loginLabel.text = label
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        updateLoginLabel()
    }
    
    func fetchUserInfo(callback: @escaping (_: Bool, _: User?) -> Void) {
        DispatchQueue.main.async {
            SwiftSpinner.show("FETCHING_USER_INFO".lz(), animated: true)
        }
        
        if(FBSDKAccessToken.current() != nil) {
            print("USer is logged")
            
            let fbRequest = FBSDKGraphRequest.init(graphPath: "me?fields=id,name,email,friends,picture", parameters: nil)
            fbRequest!.start(completionHandler: { (_: FBSDKGraphRequestConnection?, result: Any?, error: Error?) in
                
                if error != nil {
                    print("Error")
                    print(error!)
                    
                    callback(false, nil)
                    return
                } else if (result != nil) {
                    
                    if let result = result as? Dictionary<String, Any> {
                        let name = result["name"]! as! String
                        let email = result["email"]! as! String
                        let id = result["id"]! as! String
                        let pictureUrl = "https://graph.facebook.com/\(id)/picture?type=normal"
                        
                        let user = User(name: name, email: email, id: id, profilePictureUrl: pictureUrl)
                        callback(true, user)
                        return
                    } else {
                        print("Error - 0x1")
                        callback(false, nil)
                    }
                }
            })
        } else {
            SwiftSpinner.hide()
        }
        
    }
    
    
    private func loginResult(success: Bool, user: User?) {
        
        if(!success) {
            self.updateLoginLabel()
            displayAlert(viewController: self, title: "Erreur", message: "Fetching user info - 02")
            return
        }
        
        else if(user != nil) {
            user!.printPretty()
            ControllerUser.getUserBy(id: user!.id, completition: { (userAPI: User?) in
                if(userAPI == nil) {
                    
                    ControllerUser.insert(user: user!, completition: { (succes: Bool) in
                        
                        if(!success) {
                            displayAlert(viewController: self, title: "Error", message: "Fetchig user info ox#")
                            return
                        }
                        
                        DispatchQueue.main.async {
                            self.goToMenu()
                        }
                        
                    })
                } else {
                    DispatchQueue.main.async {
                        self.goToMenu()
                    }
                }
                
             
            })
        } else {
            displayAlert(viewController: self, title: "Error", message: "Fetchig user info ox#")
        }
    }
    
    private func goToMenu() {
        SwiftSpinner.hide()
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewControllerID") as? MenuViewController {
            
            present(viewController, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
