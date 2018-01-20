//
//  ControllerUser.swift
//  Hack2018
//
//  Created by CharlesOlivier Demers on 18-01-20.
//  Copyright © 2018 Charles-Olivier Demers. All rights reserved.
//

import Foundation

class ControllerUser {
    
    static func getUserBy(id: String, completition: (_: User?) -> Void) {
        
        let request = URLRequest(url: NSURL(string: "\(apiAdress)/")! as URL)
        do {
            // Perform the request
            let response: AutoreleasingUnsafeMutablePointer<URLResponse?>? = nil
            
            do {
                
                NSURLConnection.sendA
                let data = try NSURLConnection.sendSynchronousRequest(request, returning: response)
                
                // Convert the data to JSON
                let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                
                if let json = jsonSerialized, let url = json["url"], let explanation = json["explanation"] {
                    print(url)
                    print(explanation)
                }
            } catch {
                completition(nil)
            }
            
        }
    }
    
    static func insert(user user: User, completition: (_: Bool) -> Void) {
        
    }
}
