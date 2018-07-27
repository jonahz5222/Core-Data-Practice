//
//  Note.swift
//  CoreDataPractice
//
//  Created by Jonah Zukosky on 7/26/18.
//  Copyright © 2018 Zukosky, Jonah. All rights reserved.
//

import UIKit
import CoreData

@objc(Note)
public class Note: NSManagedObject {
    convenience init?(title: String,body: String) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return nil}
        
        self.init(entity: Note.entity(), insertInto: managedContext)
        
        self.title = title
        self.body = body
    }
}
