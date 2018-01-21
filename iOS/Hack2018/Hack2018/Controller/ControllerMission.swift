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
        
        let a1 = Answer(text: "Roger", isCorrect: true)
        let a2 = Answer(text: "Lapin", isCorrect: false)
        let a3 = Answer(text: "Bob", isCorrect: false)
        var arrAwnser = [Answer]()
        arrAwnser.append(a1)
        arrAwnser.append(a2)
        arrAwnser.append(a3)
        
        let Q1 = Question(title: "Quel est ton nom?", answer: arrAwnser)
        let coord = CLLocationCoordinate2D(latitude: 40, longitude: 40)
        let mission = Mission(title: "Mission Centro", description: "Description de la mission super cool au centro", position: coord, reward: 10, questions: [Q1], feedback: "Je suis le feedback pas utile", lang: kCurrentUser.lang, completed: false)
        
        completition([mission])
        
    }
    
}
