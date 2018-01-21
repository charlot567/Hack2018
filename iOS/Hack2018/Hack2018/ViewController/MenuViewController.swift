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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initAllView()
        self.navBar = NavBar()
        self.view.addSubview(navBar)
        
        NotificationCenter.default.addObserver(self, selector: #selector(goToProfile), name: notifShowProfileName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(logout), name: logoutNotifName, object: nil)
        
        ControllerDidYouKnow.get { (dyns: [DidYouKnow]) in
            ControllerDidYouKnow.save(dyns: dyns)
        }
        
        
        goToMissionsListView()
        
        UNUserNotificationCenter.current().delegate = self
        
        
        //  CHOIX DES LANGUES .... \\\\\\\\\\\\\\\
    }
    
    private func initAllView() {
        
        profileView = ProfileView(frame: self.view.frame)
        missionListView = MissionListView(frame: self.view.frame)
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
    
    func goToMissionsListView() {
        SwiftSpinner.show("FETCHING_USER_INFO".lz())
        
        ControllerMission.get { (missions: [Mission]) in
            DispatchQueue.main.async {
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //  For displaying notification when app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .badge, .sound])
    }
}
