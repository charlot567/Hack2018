//
//  User.swift
//  Hack2018
//
//  Created by CharlesOlivier Demers on 18-01-20.
//  Copyright © 2018 Charles-Olivier Demers. All rights reserved.
//

import UIKit

class User {
    var name: String!
    var email: String!
    var id: String!
    var profilePictureUrl: String!
    var image: UIImage!
    var lang: String!
    var score: Int = 35
    
    init(name: String, email: String, id: String, profilePictureUrl: String, lang: String) {
        self.name = name
        self.email = email
        self.id = id
        self.profilePictureUrl = profilePictureUrl
        self.lang = lang
        
        do {
            self.image = try UIImage(data: Data(contentsOf: URL(string: profilePictureUrl)!))
        }
        catch {
            print("ERREUR FETCHIN USER IMAGE - 0x5")
        }
        
    }
    
    func loadImage() {
        
    }
    
    func printPretty() {
        let printVar = """
            =========================
            name: \(self.name)
            email: \(self.email)
            id: \(self.id)
            =========================
        """
        
        print(printVar)
    }
}
