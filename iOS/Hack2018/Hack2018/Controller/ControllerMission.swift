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
    
    
    static func get(completition: @escaping (_: [Mission]) -> Void) {

        let parameters = ["userId": kCurrentUser.id, "lang": "fr"]
        
        guard let url = URL(string: "\(apiAdress)/mission/getAll") else { return }
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
                    
                    var missions = [Mission]()
                    
                    if let json = json as? [Dictionary<String, Any>] {
                        for info in json {
                        
                            let reward = info["reward"] as! Int
                            let title = info["title"] as! String
                            let pos = info["position"] as! Dictionary<String, Any>
                            let lat = pos["lat"] as! Double
                            let long = pos["long"] as! Double
                            let postQuestion = info["postQuestion"] as! Dictionary<String, Any>
                            let correct = postQuestion["correct"] as! String
                            let wrong = postQuestion["wrong"] as! String
                            let questionsArr = info["question"] as! Dictionary<String, Any>
                            let question = questionsArr["question"] as! String
                            let answersArr = questionsArr["answers"] as! [String]
                            let correctIndex = questionsArr["correctAnswerIndex"] as! Int
                            
                            var questionAnswerFinal = [Answer]()
                            let tempIndex = 0
                            
                            for ans in answersArr {
                                questionAnswerFinal.append(Answer(text: ans, isCorrect: tempIndex == correctIndex))
                            }
                            
                            let q1 = Question(title: question, answer: questionAnswerFinal)
                            let coord = CLLocationCoordinate2D(latitude: lat, longitude: long)
                            let feedback = Feedback(good: correct, wrong: wrong)
                            missions.append(Mission(title: title, description: "", position: coord, reward: reward, questions: q1, lang: kCurrentUser.lang, status: .toDo, feedback: feedback))
                            
                            
                        }
                        
                        
                        completition(missions)
                    }
                    
                } catch {
                    print("error")
                    
                }
            }
            
            }.resume()
        
    }
    
}
