//
//  AcceptMissionView.swift
//  Hack2018
//
//  Created by CharlesOlivier Demers on 18-01-20.
//  Copyright © 2018 Charles-Olivier Demers. All rights reserved.
//

import UIKit
import MapKit

class AcceptMissionView: UIView, CLLocationManagerDelegate {
    
    var scrollView: UIScrollView!
    var mission: Mission!
    private var mapView: MKMapView!
    private let navBar = NavBar()
    private let subtitle = UILabel()
    private let statusLbl = UILabel()
    private let rewardLbl = UILabel()
    private let startBtn = UIButton()
    let title = UILabel()
    let status = UILabel()
    let reward = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        let locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: navBar.frame.height, width: kWidth, height: kHeight - navBar.frame.height)
        self.addSubview(scrollView)
        
        mapView = MKMapView()
        mapView.frame = CGRect(x: 0, y: 0, width: kWidth, height: kWidth)
        mapView.showsUserLocation = true
        scrollView.addSubview(mapView)
        
        
        title.frame = CGRect(x: 20, y: mapView.frame.maxY + 35, width: kWidth, height: 30)
        title.font = UIFont(name: "Arial-BoldMT", size: 25)
        title.text = "MISSION".lz()
        title.textColor = UIColor.black
        scrollView.addSubview(title)
        
        subtitle.frame = CGRect(x: 20, y: title.frame.maxY, width: kWidth - 40, height: 20)
        subtitle.font = UIFont(name: "Arial", size: 18)
        subtitle.textColor = UIColor.black
        scrollView.addSubview(subtitle)
        
        
        status.frame = CGRect(x: 20, y: subtitle.frame.maxY + 35, width: kWidth, height: 30)
        status.font = UIFont(name: "Arial-BoldMT", size: 25)
        status.text = "STATUS".lz()
        status.textColor = UIColor.black
        scrollView.addSubview(status)
        
        statusLbl.frame = CGRect(x: 20, y: status.frame.maxY, width: kWidth, height: 20)
        statusLbl.font = UIFont(name: "Arial", size: 18)
        statusLbl.textColor = UIColor.black
        scrollView.addSubview(statusLbl)
        
        
        reward.frame = CGRect(x: 20, y: statusLbl.frame.maxY + 35, width: kWidth, height: 30)
        reward.font = UIFont(name: "Arial-BoldMT", size: 25)
        reward.text = "REWARD".lz()
        reward.textColor = UIColor.black
        scrollView.addSubview(reward)
        
        rewardLbl.frame = CGRect(x: 20, y: reward.frame.maxY, width: kWidth, height: 20)
        rewardLbl.font = UIFont(name: "Arial", size: 18)
        rewardLbl.textColor = UIColor.black
        scrollView.addSubview(rewardLbl)
        
        
        startBtn.frame = CGRect(x: 0, y: rewardLbl.frame.maxY + 35, width: kWidth, height: 100)
        startBtn.addTarget(self, action: #selector(start), for: .touchUpInside)
        startBtn.setTitle("START_MISSION".lz(), for: .normal)
        startBtn.setTitleColor(.white, for: .normal)
        startBtn.backgroundColor = UIColor(red: 42 / 255, green: 93 / 255, blue: 149 / 255, alpha: 1)
        scrollView.addSubview(startBtn)
        
        scrollView.contentSize = CGSize(width: kWidth, height: startBtn.frame.maxY - 20)
    }
    
    func setupView() {
        var title = mission.title
        
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
        
        if(self.mission.status == .completed) {
            self.startBtn.isHidden = true
        } else {
            self.startBtn.isHidden = false
        }
    }
    
    func updateUI() {
        
        if(mission != nil) {
            self.rewardLbl.text = "\(self.mission.reward!) \("POINT".lz())"
            self.statusLbl.text = (self.mission.status == .completed) ? "COMPLETE".lz() : "TODO".lz()
            self.title.text = "MISSION".lz()
            status.text = "STATUS".lz()
            reward.text = "REWARD".lz()
        }
    }
    
    @objc
    func start() {
        self.mission.status = .inProgress
        self.startBtn.isHidden = true
        
        DispatchQueue.main.async {
            self.statusLbl.text = "IN_PROGRESS".lz()
            
            let timerInterval: TimeInterval = 2
            addNotification(title: "ARRIVE".lz(), body: "BRAVO".lz(), timeInteval: timerInterval, userInfo: nil)
            
            Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: false, block: { (_: Timer) in
                DispatchQueue.main.async {
                    self.popQuestion()
                }
            })
        }
        
    }
    
    func popQuestion() {
        // ALEX: CALL ARVIEW WITH MISSION IN PARAMETER
        var ARVC = ARViewController(mission: mission)
        self.parentViewController?.present(ARVC, animated: true, completion: nil)
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

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
