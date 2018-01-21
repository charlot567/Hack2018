//
//  ProfileView.swift
//  Hack2018
//
//  Created by CharlesOlivier Demers on 18-01-20.
//  Copyright © 2018 Charles-Olivier Demers. All rights reserved.
//

import UIKit

class ProfileView: UIScrollView {
    
    private var navBar: NavBar!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.navBar = NavBar()
//        self.addSubview(navBar)
        
        self.backgroundColor = UIColor.white
        
        let profileImageView = UIImageView()
        profileImageView.frame = CGRect(x: 0, y: 0, width: kWidth, height: kWidth)
        profileImageView.image = kCurrentUser.image
        self.addSubview(profileImageView)
        
        let name = UILabel()
        name.frame = CGRect(x: 20, y: profileImageView.frame.maxY - 35, width: kWidth, height: 30)
        name.font = UIFont(name: "Arial-BoldMT", size: 25)
        name.text = kCurrentUser.name
        name.textColor = UIColor.white
        self.addSubview(name)
        
        let langTitle = UILabel()
        langTitle.frame = CGRect(x: name.frame.minX, y: profileImageView.frame.maxY + 35, width: kWidth, height: 25)
        langTitle.font = UIFont(name: "Arial-BoldMT", size: 20)
        langTitle.text = "LANG".lz()
        langTitle.textColor = UIColor.black
        self.addSubview(langTitle)
        
        let langTitleUser = UILabel()
        langTitleUser.frame = CGRect(x: name.frame.minX, y: langTitle.frame.maxY, width: kWidth, height: 25)
        langTitleUser.font = UIFont(name: "Arial", size: 16)
        langTitleUser.text = kCurrentUser.lang
        langTitleUser.textColor = UIColor.black
        self.addSubview(langTitleUser)
        
        let scoreTitle = UILabel()
        scoreTitle.frame = CGRect(x: name.frame.minX, y: langTitleUser.frame.maxY + 35, width: kWidth, height: 25)
        scoreTitle.font = UIFont(name: "Arial-BoldMT", size: 20)
        scoreTitle.text = "SCORE".lz()
        scoreTitle.textColor = UIColor.black
        self.addSubview(scoreTitle)
        
        let scoreLabel = UILabel()
        scoreLabel.frame = CGRect(x: name.frame.minX, y: scoreTitle.frame.maxY, width: kWidth, height: 25)
        scoreLabel.font = UIFont(name: "Arial", size: 16)
        scoreLabel.text = "\(kCurrentUser.score)"
        scoreLabel.textColor = UIColor.black
        self.addSubview(scoreLabel)
        
        let backButton = UIButton()
        backButton.frame = CGRect(x: 10, y: 50, width: 30, height: 30)
        backButton.setImage(UIImage(named: "arrow"), for: .normal)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.addSubview(backButton)
        
        let logoutButton = UIButton()
        logoutButton.frame = CGRect(x: 0, y: scoreLabel.frame.maxY + 35, width: kWidth, height: 35)
        logoutButton.setTitle("DISCONNECT_FB".lz(), for: .normal)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        logoutButton.setTitleColor(.red, for: .normal)
        logoutButton.frame = CGRect(x: kWidth / 2 - logoutButton.frame.width / 2, y: logoutButton.frame.origin.y, width: logoutButton.frame.width, height: logoutButton.frame.height)
        self.addSubview(logoutButton)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(back))
        swipeGesture.direction = .right
        self.addGestureRecognizer(swipeGesture)
    }
    
    @objc
    func back() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin.x = kWidth
        }) { (_: Bool) in
            self.removeFromSuperview()
        }
    }
    
    @objc
    func logout() {
        NotificationCenter.default.post(name: logoutNotifName, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName as String)
            print("Font Names = [\(names)]")
        }
    }
}
