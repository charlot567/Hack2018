//
//  ControllerMission.swift
//  Hack2018
//
//  Created by CharlesOlivier Demers on 18-01-20.
//  Copyright © 2018 Charles-Olivier Demers. All rights reserved.
//

import UIKit
import CoreLocation

class ControllerMission {
    
    
    static func get(completition: (_: [Mission]) -> Void) {
//
//        let a1 = Answer(text: "Roger", isCorrect: true)
//        let a2 = Answer(text: "Lapin", isCorrect: false)
//        let a3 = Answer(text: "Bob", isCorrect: false)
//        var arrAwnser = [Answer]()
//        arrAwnser.append(a1)
//        arrAwnser.append(a2)
//        arrAwnser.append(a3)
//
//        let Q1 = Question(title: "Quel est ton nom?", answer: arrAwnser)
//        let coord = CLLocationCoordinate2D(latitude: 45.504384, longitude: -73.612883)
//        let mission = Mission(title: "Mission Centro", description: "Description de la mission super cool au centro", position: coord, reward: 10, questions: Q1, feedback: "Je suis le feedback pas utile", lang: kCurrentUser.lang, status: .toDo)
//
//        completition([mission])
        
        let parameters = ["userId": kCurrentUser.id]
        
        guard let url = URL(string: "\(apiAdress)/user/addUser") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    
                    print(json)
                    if let json = json as? Dictionary<String, Any> {
                       
                       
                    }
                    
                } catch {
                    
                }
            }
            
            }.resume()
        
    }
    
}
