//
//  Model.swift
//  SubjectReviewer
//
//  Created by siqi yang on 27/8/17.
//  Copyright © 2017 siqi yang. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Model{
    
    static let sharedInstance = Model()
    static var DuplicateSubject: Bool = false
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext: NSManagedObjectContext
    var subjectDB = [Subjects]()
    
    
    private init(){
        managedContext = appDelegate.persistentContainer.viewContext
        seedData()
        getSubjects()
    }
    
    // retrive subjects from database
    func getSubject(_ indexPath: IndexPath) -> Subjects
    {
        return subjectDB[indexPath.row]
    }
    
    
    
    // MARK: - CRUD
    
    
    // CRUD - Create + Update
    func saveSubject(_ code: String, name: String, rate: Int, comment: String, image: String,existing: Subjects?){
        
        // Create a new managed object and insert it into the context, so it can be saved
        // into the database
        
        Model.DuplicateSubject = false
        let entity = NSEntityDescription.entity(forEntityName: "Subjects",in:managedContext)
        
        // Update the existing object with the data passed in from the View Controller
        if let _ = existing{
            existing!.code = code
            existing!.name = name
            existing!.rate = Int16(rate)
            existing!.comment = comment
            existing!.image = image
        }
        // Create a new object and update it with the data passed in from the View Controller
        else{
            
            // Check duplication
            for eachSubject in 0..<subjectDB.count {
                if subjectDB[eachSubject].code == code {
                    Model.DuplicateSubject = true
                }
            }
            
            if Model.DuplicateSubject != true {
                // Create an object based on the Entity
                let newSubject = Subjects(entity: entity!,insertInto:managedContext)
                newSubject.code = code
                newSubject.name = name
                newSubject.rate = Int16(rate)
                newSubject.comment = comment
                newSubject.image = image
            }
 
        }
        updateDatabase()
    }
    
    
    
    // CRUD - Read
    func getSubjects(){
        do{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Subjects")
            
            let results = try managedContext.fetch(fetchRequest)
            subjectDB = results as! [Subjects]
        }
        catch let error as NSError{
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    
    
    // CRUD - Delete
    func deleteSubject(_ subject: Subjects){
        managedContext.delete(subject)
        updateDatabase()
    }
    
    
    
    // initial data
    private func seedData(){
        
        getSubjects()
        
        for sub in subjectDB{
            managedContext.delete(sub)
        }
        
        
        let entity = NSEntityDescription.entity(forEntityName: "Subjects",in:managedContext)
        let firstSubject = Subjects(entity: entity!,insertInto:managedContext)
        
        firstSubject.code = "COSC2472"
        firstSubject.name = "iPhone Software Engineering"
        firstSubject.rate = 5
        firstSubject.comment = "iPhone Software Engineering is concerned with the development of applications on the Apple iPhone and iPod Touch platforms. Current SWIFT and the Apple iOS SDK will be used as a basis for teaching programming techniques and design patterns related to the development of standalone applications and mobile portals to enterprise and m-commerce systems."
        firstSubject.image = "I"
        
        updateDatabase()
        
    }
    
    
    // Save Database status
    func updateDatabase(){
        do{
            try managedContext.save()
        }
        catch let error as NSError{
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
}
