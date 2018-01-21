//
//  AcceptMissionView.swift
//  Hack2018
//
//  Created by CharlesOlivier Demers on 18-01-20.
//  Copyright © 2018 Charles-Olivier Demers. All rights reserved.
//

import UIKit

class AcceptMissionView: UIView {
    
    var mission: Mission!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .red
        
        
    }
    
    func setupView() {
        let navBar = NavBar()
        navBar.setForMissionView(title: mission.title, acceptMissionView: self)
        self.addSubview(navBar)
    }
    
    @objc
    func back() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin.x = kWidth
        }) { (_: Bool) in
            self.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
