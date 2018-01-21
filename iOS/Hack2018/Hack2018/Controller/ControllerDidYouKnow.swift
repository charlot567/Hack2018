//
//  ControllerDidYouKnow.swift
//  Hack2018
//
//  Created by CharlesOlivier Demers on 18-01-20.
//  Copyright © 2018 Charles-Olivier Demers. All rights reserved.
//

import Foundation

class ControllerDidYouKnow {
    
    static func get(completition: @escaping (_: [DidYouKnow]) -> Void) {
        let parameters = ["lang": "fr"]
        
        guard let url = URL(string: "\(apiAdress)/didYouKnow/getByLang") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        var didYouKnows = [DidYouKnow]()
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    
                    if let json = json as? [Dictionary<String, Any>] {
                        for info in json {
                            print(info)
                            let description = info["description"] as! String
                            let id = info["_id"] as! String
                            
                            didYouKnows.append(DidYouKnow(text: description, id: id))
                        }
                        
                        completition(didYouKnows)
                    } else {
                        completition(didYouKnows)
                    }
                    
                } catch {
                    completition(didYouKnows)
                }
            }
            
            }.resume()
    }
}
