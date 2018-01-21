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
    
    var mission: Mission!
    private var mapView: MKMapView!
    private let navBar = NavBar()
    
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
