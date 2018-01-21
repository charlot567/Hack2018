//
//  DYN+CoreDataProperties.swift
//  
//
//  Created by Alex Morin on 18-01-21.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension DYN {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DYN> {
        return NSFetchRequest<DYN>(entityName: "DYN")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?

}
