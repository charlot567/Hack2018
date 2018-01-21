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
    
    static func getUserBy(id: String, completition: (_: User?) -> Void) {
        
        Alamofire.request("\(apiAdress)/getUser").responseJSON { response in
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        
    }
    
    static func insert(user user: User, completition: (_: Bool) -> Void) {
        
    }
}
