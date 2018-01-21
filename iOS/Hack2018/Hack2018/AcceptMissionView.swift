//
//  AcceptMissionView.swift
//  Hack2018
//
//  Created by CharlesOlivier Demers on 18-01-20.
//  Copyright © 2018 Charles-Olivier Demers. All rights reserved.
//

import UIKit
import MapKit

class AcceptMissionView: UIScrollView, CLLocationManagerDelegate {
    
    var mission: Mission!
    private var mapView: MKMapView!
    private let navBar = NavBar()
    private let subtitle = UILabel()
    private let statusLbl = UILabel()
    private let rewardLbl = UILabel()
    private let startBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        let locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        mapView = MKMapView()
        mapView.frame = CGRect(x: 0, y: navBar.frame.maxY, width: kWidth, height: kWidth)
        mapView.showsUserLocation = true
        self.addSubview(mapView)
        
        let title = UILabel()
        title.frame = CGRect(x: 20, y: mapView.frame.maxY + 35, width: kWidth, height: 30)
        title.font = UIFont(name: "Arial-BoldMT", size: 25)
        title.text = "MISSION".lz()
        title.textColor = UIColor.black
        self.addSubview(title)
        
        subtitle.frame = CGRect(x: 20, y: title.frame.maxY, width: kWidth, height: 20)
        subtitle.font = UIFont(name: "Arial", size: 18)
        subtitle.textColor = UIColor.black
        self.addSubview(subtitle)
        
        let status = UILabel()
        status.frame = CGRect(x: 20, y: subtitle.frame.maxY + 35, width: kWidth, height: 30)
        status.font = UIFont(name: "Arial-BoldMT", size: 25)
        status.text = "STATUS".lz()
        status.textColor = UIColor.black
        self.addSubview(status)
        
        statusLbl.frame = CGRect(x: 20, y: status.frame.maxY, width: kWidth, height: 20)
        statusLbl.font = UIFont(name: "Arial", size: 18)
        statusLbl.textColor = UIColor.black
        self.addSubview(statusLbl)
        
        let reward = UILabel()
        reward.frame = CGRect(x: 20, y: statusLbl.frame.maxY + 35, width: kWidth, height: 30)
        reward.font = UIFont(name: "Arial-BoldMT", size: 25)
        reward.text = "REWARD".lz()
        reward.textColor = UIColor.black
        self.addSubview(reward)
        
        rewardLbl.frame = CGRect(x: 20, y: reward.frame.maxY, width: kWidth, height: 20)
        rewardLbl.font = UIFont(name: "Arial", size: 18)
        rewardLbl.textColor = UIColor.black
        self.addSubview(rewardLbl)
        
        
        startBtn.frame = CGRect(x: 0, y: rewardLbl.frame.maxY + 35, width: kWidth, height: 100)
        startBtn.addTarget(self, action: #selector(start), for: .touchUpInside)
        startBtn.setTitle("START_MISSION".lz(), for: .normal)
        startBtn.setTitleColor(.white, for: .normal)
        startBtn.backgroundColor = UIColor(red: 42 / 255, green: 93 / 255, blue: 149 / 255, alpha: 1)
        self.addSubview(startBtn)
        
        self.contentSize = CGSize(width: kWidth, height: startBtn.frame.maxY - 20)
    }
    
    func setupView() {
        
        navBar.setForMissionView(title: mission.title, acceptMissionView: self)
        self.addSubview(navBar)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = mission.position
        mapView.addAnnotation(annotation)
        
        var mapRegion = MKCoordinateRegion()
        mapRegion.center = mission.position
        mapRegion.span.latitudeDelta = 0.2
        mapRegion.span.longitudeDelta = 0.2
        mapView.setRegion(mapRegion, animated: true)

        DispatchQueue.main.async {
            self.subtitle.text = self.mission.title
            self.statusLbl.text = (self.mission.status == .completed) ? "COMPLETE".lz() : "TODO".lz()
            
            if(self.mission.status == .inProgress) {
                self.statusLbl.text = "IN_PROGRESS".lz()
            }
            self.rewardLbl.text = "\(self.mission.reward!) \("POINT".lz())"
        }
        
        
    }
    
    @objc
    func start() {
        self.mission.status = .inProgress
        self.startBtn.isHidden = true
        
        DispatchQueue.main.async {
            self.statusLbl.text = "IN_PROGRESS".lz()
            
            let timerInterval: TimeInterval = 2
            addNotification(title: "ARRIVE".lz(), body: "BRAVO".lz(), timeInteval: timerInterval)
            
            Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: false, block: { (_: Timer) in
                DispatchQueue.main.async {
                    self.popQuestion()
                }
            })
        }
        
    }
    
    func popQuestion() {
        print("POP")
    }
    
    @objc
    func back() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin.x = kWidth
        }) { (_: Bool) in
            self.removeFromSuperview()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
