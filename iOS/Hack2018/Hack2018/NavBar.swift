//
//  NavBar.swift
//  Hack2018
//
//  Created by CharlesOlivier Demers on 18-01-20.
//  Copyright © 2018 Charles-Olivier Demers. All rights reserved.
//

import UIKit

class NavBar: UIView {
    
    private var titleLabel: UILabel!
    
    init() {
        let navBarHeight: CGFloat = 100
        super.init(frame: CGRect(x: 0, y: 0, width: kWidth, height: navBarHeight))
        self.backgroundColor = UIColor.white
        
        titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 0, y: navBarHeight - 40, width: kWidth, height: 20)
        titleLabel.font = UIFont(name: "Arial", size: 20)
        titleLabel.textAlignment = .center
        titleLabel.text = kCurrentUser.name
        self.addSubview(titleLabel)
        
        let imageSize: CGFloat = 40
        let profileButton = UIButton()
        profileButton.frame = CGRect(x: kWidth - imageSize * 1.5, y: navBarHeight - imageSize - 15, width: imageSize, height: imageSize)
        profileButton.setImage(kCurrentUser.image, for: .normal)
        profileButton.addTarget(self, action: #selector(showProfile), for: .touchUpInside)
        profileButton.clipsToBounds = true
        profileButton.layer.cornerRadius = imageSize / 2
        self.addSubview(profileButton)
     
        
    }
    
    @objc func showProfile() {
        print("Show profile")
        NotificationCenter.default.post(name: notifShowProfileName, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
