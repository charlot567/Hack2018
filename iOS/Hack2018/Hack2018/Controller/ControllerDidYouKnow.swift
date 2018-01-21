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
        
        for dyn in dyns {
            
            if(exist(id: dyn.id)) {
                print("Add to coredata: \(dyn.id)")
                
                let entity = NSEntityDescription.entity(forEntityName: "DYN", in: context)
                let d = NSManagedObject(entity: entity!, insertInto: context)
                
                d.setValue(dyn.id, forKey: "id")
                d.setValue(dyn.text, forKey: "title")
                
                let center = UNUserNotificationCenter.current()
                
                let nl = UILocalNotification()
                let calendar = Calendar.current
                let newDate = calendar.date(byAdding: .second, value: 30, to: Date())
                print("date: \(newDate)")
                nl.fireDate = newDate
                nl.alertBody = "Salut"
                
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
