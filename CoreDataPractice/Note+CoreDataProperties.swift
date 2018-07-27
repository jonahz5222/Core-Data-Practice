//
//  Note+CoreDataProperties.swift
//  CoreDataPractice
//
//  Created by Jonah Zukosky on 7/26/18.
//  Copyright © 2018 Zukosky, Jonah. All rights reserved.
//

import UIKit
import CoreData


extension Note {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }
    
    @NSManaged public var title: String
    @NSManaged public var body: String
    
}
