//
//  ControllerDidYouKnow.swift
//  Hack2018
//
//  Created by CharlesOlivier Demers on 18-01-20.
//  Copyright © 2018 Charles-Olivier Demers. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

class ControllerDidYouKnow {
    
    static func get(completition: @escaping (_: [DidYouKnow]) -> Void) {
        let user = UserDefaults.standard
        var lang = user.value(forKey: "LANGUAGE") as? String
        
        if(lang == nil) {
            lang = "fr"
        }
        
        let parameters = ["lang": lang]
        
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
    
    static func save(dyns: [DidYouKnow]) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        var timeInteval: TimeInterval = 60
        let skip: TimeInterval = 120
        
        for dyn in dyns {
            
            //  DONT FORGET TO replace exist with !exist
            if(!exist(id: dyn.id)) {
                print("Add to coredata: \(dyn.id)")
                
                let entity = NSEntityDescription.entity(forEntityName: "DYN", in: context)
                let d = NSManagedObject(entity: entity!, insertInto: context)
                
                d.setValue(dyn.id, forKey: "id")
                d.setValue(dyn.text, forKey: "title")
                
                addNotification(title: "FUN_FACT".lz(), body: dyn.text, timeInteval: timeInteval, userInfo: ["openDYN": dyn.text])
                timeInteval += skip
                
                do {
                    try context.save()
                } catch {
                    print("Failed saving")
                }
            }
        }
    }
    
    private static func exist(id: String) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DYN")
        request.predicate = NSPredicate(format: "id = %@", id)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            return (result as! [NSManagedObject]).count > 0
        } catch {

        }
        
        return false
    }
}
