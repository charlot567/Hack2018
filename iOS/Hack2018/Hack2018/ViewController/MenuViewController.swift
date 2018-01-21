//
//  MenuViewController.swift
//  Hack2018
//
//  Created by CharlesOlivier Demers on 18-01-20.
//  Copyright © 2018 Charles-Olivier Demers. All rights reserved.
//

import UIKit
import UserNotifications
import SwiftSpinner
import CoreLocation

class MenuViewController: UIViewController, UNUserNotificationCenterDelegate {

    private var navBar: NavBar!
    
    private var profileView: ProfileView!
    private var missionListView: MissionListView!
    
    let topButton = UIButton()
    let middleButton = UIButton()
    let bottomButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuViewController = self
        initAllView()
        self.navBar = NavBar()
        self.view.addSubview(navBar)
        
        NotificationCenter.default.addObserver(self, selector: #selector(goToProfile), name: notifShowProfileName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(logout), name: logoutNotifName, object: nil)
        
        ControllerDidYouKnow.get { (dyns: [DidYouKnow]) in
            ControllerDidYouKnow.save(dyns: dyns)
        }
        
    
        
        UNUserNotificationCenter.current().delegate = self
        
        let height = (kHeight - navBar.frame.height) / 3
        topButton.frame = CGRect(x: 0, y: navBar.frame.maxY, width: kWidth, height: height)
        topButton.backgroundColor = UIColor(red: 6 / 255, green: 70 / 255, blue: 91 / 255, alpha: 1)
        topButton.layer.borderWidth = 1
        topButton.layer.borderColor = UIColor.white.cgColor
        topButton.setTitle("TABLEVIEW".lz(), for: .normal)
        topButton.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 35)
        topButton.addTarget(self, action: #selector(goToMissionsListView), for: .touchUpInside)
        topButton.setTitleColor(.white, for: .normal)
        self.view.addSubview(topButton)
        
        middleButton.frame = CGRect(x: 0, y: topButton.frame.maxY, width: kWidth, height: height)
        middleButton.backgroundColor = UIColor(red: 18 / 255, green: 129 / 255, blue: 158 / 255, alpha: 1)
        middleButton.layer.borderWidth = 1
        middleButton.layer.borderColor = UIColor.white.cgColor
        middleButton.setTitle("NAO".lz(), for: .normal)
        middleButton.setTitleColor(.white, for: .normal)
        middleButton.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 35)
        middleButton.addTarget(self, action: #selector(goToNao), for: .touchUpInside)
        self.view.addSubview(middleButton)
        
        bottomButton.frame = CGRect(x: 0, y: middleButton.frame.maxY, width: kWidth, height: height)
        bottomButton.backgroundColor = UIColor(red: 29 / 255, green: 180 / 255, blue: 222 / 255, alpha: 1)
        bottomButton.layer.borderWidth = 1
        bottomButton.layer.borderColor = UIColor.white.cgColor
        bottomButton.setTitle("LANG".lz(), for: .normal)
        bottomButton.setTitleColor(.white, for: .normal)
        bottomButton.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 35)
        bottomButton.addTarget(self, action: #selector(askLanguage), for: .touchUpInside)
        self.view.addSubview(bottomButton)
        
        //  CHOIX DES LANGUES .... \\\\\\\\\\\\\\\
    }
    
    private func initAllView() {
        
        profileView = ProfileView(frame: self.view.frame)
        missionListView = MissionListView(frame: self.view.frame)
    }
    
    @objc func askLanguage() {
        let alert = UIAlertController(title: "LANG".lz(), message: "USE_LANG".lz(), preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Français", style: .default, handler: { (_) in
            DispatchQueue.main.async {
                self.setUserLang(lang: "fr")
            }
        }))
        alert.addAction(UIAlertAction(title: "Anglais", style: .default, handler:{ (_) in
            DispatchQueue.main.async {
                self.setUserLang(lang: "en")
            }
        }))
        alert.addAction(UIAlertAction(title: "Espagnol", style: .default, handler: { (_) in
            DispatchQueue.main.async {
                self.setUserLang(lang: "es")
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setUserLang(lang: String) {
        let user = UserDefaults.standard
        user.set("\(lang)", forKey: "LANGUAGE")
        user.synchronize()
        
        updateUI()
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.topButton.setTitle("TABLEVIEW".lz(), for: .normal)
            self.middleButton.setTitle("NAO".lz(), for: .normal)
            self.bottomButton.setTitle("LANG".lz(), for: .normal)
            
            self.missionListView.updateBar()
        }
    }
    
    @objc private func goToProfile() {
        self.profileView.frame.origin.x = kWidth
        self.view.addSubview(profileView)
        UIView.animate(withDuration: 0.3, animations: {
            self.profileView.frame.origin.x = 0
        }) { (_: Bool) in
            
        }
    }
    
    @objc func logout() {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewControllerID") as? LoginViewController {
            viewController.logoutPlease = true
            
            present(viewController, animated: true, completion: {
                self.profileView.removeFromSuperview()
            })
        }
    }

    @objc func openAmigo() {
        print("OpenAmigo")
    }
    
    @objc func goToMissionsListView() {
        SwiftSpinner.show("FETCHING_USER_INFO".lz())
        
        ControllerMission.get { (missions: [Mission]) in
            DispatchQueue.main.async {
                SwiftSpinner.hide()
                
                self.missionListView.missions = missions
                self.missionListView.frame.origin.x = kWidth
                self.view.addSubview(self.missionListView)
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.missionListView.frame.origin.x = 0
                }) { (_: Bool) in
                    
                }
            }
        }
    }
    
    @objc
    func goToNao() {
        print("NAO")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //  For displaying notification when app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .badge, .sound])
    }
}
