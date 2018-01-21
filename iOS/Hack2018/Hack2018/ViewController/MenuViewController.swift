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
    
    private var profileView: ProfileView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initAllView()
        self.navBar = NavBar()
        self.view.addSubview(navBar)
        
        goToProfile()
    }
    
    private func initAllView() {
        
        profileView = ProfileView(frame: self.view.frame)
    }
    
    private func goToProfile() {
        self.view.addSubview(profileView)
    }

    @objc func openAmigo() {
        print("OpenAmigo")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
