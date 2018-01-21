//
//  Mission.swift
//  Hack2018
//
//  Created by CharlesOlivier Demers on 18-01-20.
//  Copyright © 2018 Charles-Olivier Demers. All rights reserved.
//

import Foundation
import CoreLocation

class Mission {
    var id: String!
    var title: String!
    var description: String!
    var position: CLLocationCoordinate2D!
    var reward: Int!
    var questions: Question!
    var lang: String!
    var status: Status!
    var feedback: Feedback!
    
    init(title: String, description: String, position: CLLocationCoordinate2D, reward: Int, questions: Question, lang: String, status: Status, feedback: Feedback, id: String) {
        
        self.id = id
        self.title = title
        self.description = description
        self.position = position
        self.reward = reward
        self.questions = questions
    
        self.lang = lang
        self.status = status
        self.feedback = feedback
    }
}

struct Question {
    var title: String!
    var answer = [Answer]()
}

struct Answer {
    var text: String!
    var isCorrect: Bool!
}

enum Status {
    case inProgress
    case completed
    case toDo
}

struct Feedback {
    var good: String!
    var wrong: String!
}
