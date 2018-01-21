//
//  ProfileView.swift
//  Hack2018
//
//  Created by CharlesOlivier Demers on 18-01-20.
//  Copyright © 2018 Charles-Olivier Demers. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    private var navBar: NavBar!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.navBar = NavBar()
//        self.addSubview(navBar)
        
        self.backgroundColor = UIColor.white
//        let topView = UIView()
//        topView.frame = CGRect(x: 0, y: navBar.frame.height, width: kWidth, height: 250)
//        topView.backgroundColor = UIColor(red: 0, green: 101 / 255, blue: 255 / 255, alpha: 1)
//        self.addSubview(topView)
        
        let profileImageView = UIImageView()
        profileImageView.frame = CGRect(x: 0, y: 0, width: kWidth, height: kWidth)
//        profileImageView.layer.cornerRadius = imageSize / 2
        profileImageView.image = kCurrentUser.image
        self.addSubview(profileImageView)
        
        let name = UILabel()
        name.frame = CGRect(x: 20, y: profileImageView.frame.maxY - 35, width: kWidth, height: 30)
        name.font = UIFont(name: "Arial", size: 25)
        name.text = kCurrentUser.name
        name.textColor = UIColor.white
        self.addSubview(name)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
