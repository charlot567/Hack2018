//
//  MissionListView.swift
//  Hack2018
//
//  Created by CharlesOlivier Demers on 18-01-20.
//  Copyright © 2018 Charles-Olivier Demers. All rights reserved.
//

import UIKit

class MissionListView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    private var tableView: UITableView!
    var missions = [Mission]()
    
    private var acceptMissionView: AcceptMissionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        acceptMissionView = AcceptMissionView(frame: self.frame)
        
        tableView = UITableView(frame: frame)
        tableView.dataSource = self
        tableView.delegate = self
        self.addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "reuseCellID")
        
        cell.textLabel?.text = missions[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        acceptMissionView.mission = missions[indexPath.row]
        acceptMissionView.setupView()
        self.acceptMissionView.frame.origin.x = kWidth
        self.addSubview(self.acceptMissionView)
        UIView.animate(withDuration: 0.3, animations: {
            self.acceptMissionView.frame.origin.x = 0
        }) { (_: Bool) in
            
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return missions.count
    }
}
