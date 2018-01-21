//
//  Global.swift
//  Hack2018
//
//  Created by Charles-Olivier Demers on 2018-01-20.
//  Copyright © 2018 Charles-Olivier Demers. All rights reserved.
//

import UIKit
import UserNotifications

let kDebug = true
var kWidth: CGFloat = 0
var kHeight: CGFloat = 0
var IPHONE_X = false

var kCurrentUser: User!

let notifShowProfileName = NSNotification.Name(rawValue: "notifShowProfileName")
let logoutNotifName = NSNotification.Name(rawValue: "logoutNotifName")
let backMissionNotifName = NSNotification.Name(rawValue: "backMissionNotifName")
let updateScoreNotifName = NSNotification.Name(rawValue: "updateScoreNotifName")

import SwiftSpinner

func displayAlert(viewController: UIViewController, title: String, message: String) {
    if(kDebug) {
        SwiftSpinner.hide()
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}

func addNotification(title: String, body: String, timeInteval: TimeInterval) {
    let center = UNUserNotificationCenter.current()
    
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    content.sound = UNNotificationSound.default()
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInteval,
                                                    repeats: false)
    
    let identifier = "UYLLocalNotification\(timeInteval)-\(Date())"
    let request = UNNotificationRequest(identifier: identifier,
                                        content: content, trigger: trigger)
    
    center.add(request, withCompletionHandler: { (error) in
        if let error = error {
            print(error)
        }
    })
}
