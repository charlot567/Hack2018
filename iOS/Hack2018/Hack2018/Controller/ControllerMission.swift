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

        let user = UserDefaults.standard
        var lang = user.value(forKey: "LANGUAGE") as? String
        
        if(lang == nil) {
            lang = "fr"
        }
        
        let parameters = ["userId": kCurrentUser.id, "lang": lang]
        
        guard let url = URL(string: "\(apiAdress)/mission/getByLang") else { return }
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
                            let id = info["_id"] as! String
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
                            let accomplished = (info["accomplished"] as! Int)
                            print(info)
                            print(accomplished)
                            
                            var questionAnswerFinal = [Answer]()
                            let tempIndex = 0
                             
                            for ans in answersArr {
                                questionAnswerFinal.append(Answer(text: ans, isCorrect: tempIndex == correctIndex))
                            }
                            
                            let q1 = Question(title: question, answer: questionAnswerFinal)
                            let coord = CLLocationCoordinate2D(latitude: lat, longitude: long)
                            let feedback = Feedback(good: correct, wrong: wrong)
                            missions.append(Mission(title: title, description: "", position: coord, reward: reward, questions: q1, lang: kCurrentUser.lang, status: (accomplished == 1 ? .completed : .toDo), feedback: feedback, id: id))
                            
                            
                        }
                        
                        
                        completition(missions)
                    }
                    
                } catch {
                    print("error")
                    
                }
            }
            
            }.resume()
        
    }
    
    static func complete(mission: Mission) {
        
        let parameters = ["userId": kCurrentUser.id, "missionId": mission.id]
        
        guard let url = URL(string: "\(apiAdress)/user/addAccomplishedMission") else { return }
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
                    
                    if let json = json as? Dictionary<String, Any> {
                        print(json)
                          print("========")
                    }
                    
                } catch {
                    print("error")
                    
                }
            }
            
            }.resume()
        
    }
    
}
