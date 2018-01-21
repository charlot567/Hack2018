//
//  ControllerUser.swift
//  Hack2018
//
//  Created by CharlesOlivier Demers on 18-01-20.
//  Copyright © 2018 Charles-Olivier Demers. All rights reserved.
//

import Foundation
import Alamofire

class ControllerUser {
    
    static func getUserBy(id: String, completition: @escaping (_: Bool) -> Void) {
        let parameters = ["userId": id]
        
        guard let url = URL(string: "\(apiAdress)/user/getById") else { return }
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
                        let name = json["name"] as? String
                        if(name != nil) {
                            completition(true)
                        }
                    }
                    
                } catch {
                    completition(false)
                }
            }
            
        }.resume()
    }
    
    static func insert(user: User, completition: @escaping (_: Bool) -> Void) {
        
        let parameters = ["userId": user.id, "name": user.name, "email": user.email, "lang": user.lang]
        
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
                    
                    
                    if let json = json as? Dictionary<String, Any> {
                        let name = json["name"] as? String
                        if(name != nil) {
                            completition(true)
                        }
                    }
                    
                } catch {
                    completition(false)
                }
            }
            
        }.resume()
    }
}
