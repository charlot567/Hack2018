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
        titleLabel.frame = CGRect(x: 0, y: navBarHeight - 20, width: kWidth, height: 20)
        titleLabel.font = UIFont(name: "Arial", size: 20)
        titleLabel.textAlignment = .center
        titleLabel.text = "Salut"
        self.addSubview(titleLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
