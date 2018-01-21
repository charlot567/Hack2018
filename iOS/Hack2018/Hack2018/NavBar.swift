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
    private let coinImg = UIButton()
    private let coinLabel = UILabel()
    private let profileButton = UIButton()
    private var acceptMissionView: AcceptMissionView!
    private var missionListView: MissionListView!
    
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
        
        profileButton.frame = CGRect(x: kWidth - imageSize * 1.5, y: navBarHeight - imageSize - 15, width: imageSize, height: imageSize)
        profileButton.setImage(kCurrentUser.image, for: .normal)
        profileButton.addTarget(self, action: #selector(showProfile), for: .touchUpInside)
        profileButton.clipsToBounds = true
        profileButton.layer.cornerRadius = imageSize / 2
        self.addSubview(profileButton)
        
        
        
        coinImg.frame = CGRect(x: 20, y: 40, width: 40, height: 40)
        coinImg.setImage(UIImage(named: "coin"), for: .normal)
        coinImg.addTarget(self, action: #selector(buyCoin), for: .touchUpInside)
        self.addSubview(coinImg)
        
        coinLabel.frame = CGRect(x: 0, y: coinImg.frame.maxY - 5, width: 80, height: 20)
        coinLabel.font = UIFont(name: "Arial", size: 15)
        coinLabel.textAlignment = .center
        coinLabel.text = "\(kCurrentUser.score)"
        self.addSubview(coinLabel)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateScore), name: updateScoreNotifName, object: nil)
    }
    
    @objc
    func updateScore() {
        DispatchQueue.main.async {
            self.coinLabel.text = "\(kCurrentUser.score)"
        }
    }
    
    @objc
    func buyCoin() {
        
        let alert = UIAlertController(title: "SELECTED".lz(), message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Gray", style: .default, handler: { (_) in
            DispatchQueue.main.async {
                self.setSkin(value: "1")
            }
        }))
        alert.addAction(UIAlertAction(title: "White & Brown", style: .default, handler:{ (_) in
            DispatchQueue.main.async {
                self.setSkin(value: "2")
            }
        }))
        alert.addAction(UIAlertAction(title: "Brown", style: .default, handler: { (_) in
            DispatchQueue.main.async {
                self.setSkin(value: "3")
            }
        }))
        
        alert.addAction(UIAlertAction(title: "White", style: .default, handler: { (_) in
            DispatchQueue.main.async {
                self.setSkin(value: "4")
            }
        }))
        menuViewController.present(alert, animated: true, completion: nil)
        
    }
    
    private func setSkin(value: String) {
        DispatchQueue.main.async {
            let user = UserDefaults.standard
            user.set(value, forKey: "SKINVALUE")
            user.synchronize()
            
            ControllerUser.updateScore(score: -8)
        }
        
    }
    
    func setForMissionView(title: String, acceptMissionView: AcceptMissionView) {
        updateTitle(title: title)
        self.titleLabel.frame.size = CGSize(width: kWidth / 2, height: titleLabel.frame.height)
        self.titleLabel.frame.origin = CGPoint(x: kWidth / 4, y: self.titleLabel.frame.origin.y)
        coinImg.removeFromSuperview()
        coinLabel.removeFromSuperview()
        profileButton.removeFromSuperview()
        self.acceptMissionView = acceptMissionView
        
        let backButton = UIButton()
        backButton.frame = CGRect(x: 10, y: 50, width: 30, height: 30)
        backButton.setImage(UIImage(named: "arrow_black"), for: .normal)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.addSubview(backButton)
    }
    
    func setForTableview(title: String, missionListView: MissionListView) {
        updateTitle(title: title)
        
        coinImg.removeFromSuperview()
        coinLabel.removeFromSuperview()
        profileButton.removeFromSuperview()
        self.missionListView = missionListView
        
        let backButton = UIButton()
        backButton.frame = CGRect(x: 10, y: 50, width: 30, height: 30)
        backButton.setImage(UIImage(named: "arrow_black"), for: .normal)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        self.addSubview(backButton)
    }
    
    func updateTitle(title: String) {
        DispatchQueue.main.async {
            self.titleLabel.text = title
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        back()
    }
    
    
    @objc
    func back() {
        if(acceptMissionView != nil) {
            acceptMissionView.back()
            
            acceptMissionView = nil
        } else if(missionListView != nil) {
            missionListView.back()
//            missionListView = nil
        }
    }
    
    @objc
    func showProfile() {
        print("Show profile")
        NotificationCenter.default.post(name: notifShowProfileName, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
