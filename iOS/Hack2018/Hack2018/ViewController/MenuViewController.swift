//
//  MenuViewController.swift
//  Hack2018
//
//  Created by CharlesOlivier Demers on 18-01-20.
//  Copyright © 2018 Charles-Olivier Demers. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    private var navBar: NavBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navBar = NavBar()
        self.view.addSubview(navBar)
    }

    @objc func openAmigo() {
        print("OpenAmigo")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
