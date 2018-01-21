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
    private var navBar: NavBar!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        acceptMissionView = AcceptMissionView(frame: self.frame)
        
        self.navBar = NavBar()
        self.navBar.setForTableview(title: "TABLEVIEW".lz(), missionListView: self)
        
        self.addSubview(navBar)
        
        tableView = UITableView(frame: CGRect(x: 0, y: navBar.frame.height, width: kWidth, height: kHeight - navBar.frame.height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "ReuseID")
        self.addSubview(tableView)
    }
    
    func back() {
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin.x = kWidth
        }) { (_: Bool) in
            self.removeFromSuperview()
        }
    }
    
    func updateBar() {
        self.navBar.updateTitle(title: "TABLEVIEW".lz())
        self.tableView.reloadData()
        self.acceptMissionView.updateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReuseID") as! CustomCell
        
        cell.title.text = missions[indexPath.row].title
        cell.status.text = getStatusLabel(status: missions[indexPath.row].status)
        
        return cell
    }
    
    func reloadData() {
        ControllerMission.get { (missions: [Mission]) in
            self.missions = missions
            self.tableView.reloadData()
        }
    }
    
    func getStatusLabel(status: Status) -> String {
        if(status == .completed) {
            return "COMPLETE".lz()
        } else if(status == .inProgress) {
            return "IN_PROGRESS".lz()
        }
        
        return "TODO".lz()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
