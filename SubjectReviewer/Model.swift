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
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let managedContext: NSManagedObjectContext
    var subjectDB = [Subjects]()
    
    
    private init(){
        managedContext = appDelegate.persistentContainer.viewContext
        seedData()
        getSubjects()
        
        print("added seed data")

    }
    
    func getSubject(_ indexPath: IndexPath) -> Subjects
    {
        return subjectDB[indexPath.row]
    }
    
    
    
    // MARK: - CRUD
    
    
    // CRUD - Create + Update
    func saveSubject(_ code: String, name: String, rate: Int, comment: String, image: String,existing: Subjects?){
        
        // Create a new managed object and insert it into the context, so it can be saved
        // into the database
        
        var DuplicateSubject: Bool = false
        let entity = NSEntityDescription.entity(forEntityName: "Subjects",in:managedContext)
        
        // Update the existing object with the data passed in from the View Controller
        if let _ = existing{
            existing!.code = code
            existing!.name = name
            existing!.rate = Int16(rate)
            existing!.comment = comment
            existing!.image = image
        }
        // Create a new movie object and update it with the data passed in from the View Controller
        else{
            
            // Check duplication
            for eachSubject in 0..<subjectDB.count {
                if subjectDB[eachSubject].code == code {
                    print("sorry the subject is already int the list")
                    // POP up Duplicate subject warning
                    DuplicateSubject = true
                }
            }
            
            if DuplicateSubject != true {

                // Create an object based on the Entity
                let newSubject = Subjects(entity: entity!,insertInto:managedContext)
                newSubject.code = code
                newSubject.name = name
                newSubject.rate = Int16(rate)
                newSubject.comment = comment
                newSubject.image = image

            }
            
            DuplicateSubject = false
            
        }
        
        updateDatabase()
        
    }
    
    
    
    // CRUD - Read
    func getSubjects()
    {
        do
        {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Subjects")
            
            let results = try managedContext.fetch(fetchRequest)
            subjectDB = results as! [Subjects]
        }
        catch let error as NSError
        {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

    
    

    
    // CRUD - Delete
    func deleteSubject(_ subject: Subjects)
    {
        managedContext.delete(subject)
        updateDatabase()
    }
    
    
    
    // initial data
    private func seedData(){
        
        getSubjects()
        
        for sub in subjectDB
        {
            managedContext.delete(sub)
        }
        
        
        let entity = NSEntityDescription.entity(forEntityName: "Subjects",in:managedContext)
        let firstSubject = Subjects(entity: entity!,insertInto:managedContext)
        
        firstSubject.code = "COSC2472"
        firstSubject.name = "iPhone Software Engineering"
        firstSubject.rate = 5
        firstSubject.comment = "iPhone Software Engineering is concerned with the development of applications on the Apple iPhone and iPod Touch platforms. Current SWIFT and the Apple iOS SDK will be used as a basis for teaching programming techniques and design patterns related to the development of standalone applications and mobile portals to enterprise and m-commerce systems."
        firstSubject.image = "I"
        
        
//        let entity2 = NSEntityDescription.entity(forEntityName: "Subjects",in:managedContext)
//        let secondSubject = Subjects(entity: entity2!,insertInto:managedContext)
//        
//        secondSubject.code = "COSC2472"
//        secondSubject.name = "iPhone Software Engineering"
//        secondSubject.rate = 5
//        secondSubject.comment = "iPhone Software Engineering is concerned with the development of applications on the Apple iPhone and iPod Touch platforms. Current SWIFT and the Apple iOS SDK will be used as a basis for teaching programming techniques and design patterns related to the development of standalone applications and mobile portals to enterprise and m-commerce systems."
//        secondSubject.image = "I"
        
        updateDatabase()
        
    }
    
    
    // Save Database status
    func updateDatabase()
    {
        do
        {
            try managedContext.save()
        }
        catch let error as NSError
        {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    

    
    
    //    var code: String! = nil
    //    var name: String! = nil
    //    var rate: Int! = nil
    //    var comment: String! = nil
    //    var image: UIImage! = #imageLiteral(resourceName: "A")//Image.image[0]
    //
    //    var manySubjects = [Subject]()
    //
    //    var newSubject: Subject! = nil
    //
    //    var DuplicateSubject: Bool = false
    //
    //
    //
    //    func addNewCode(code: String){
    //        self.code = code
    //
    //    }
    //
    //    func addNewName(name: String){
    //        self.name = name
    //
    //
    //    }
    //
    //    func addNewRate(rate: Int){
    //        self.rate = rate
    //
    //    }
    //
    //    func addNewComment(comment: String){
    //        self.comment = comment
    //
    //    }
    //
    //    func addNewImage(image: UIImage){
    //        self.image = image
    //    }
    //
    //
    //    //Signleton
    //    private struct Static {
    //        static var instance: Model?
    //    }
    //
    //    class var sharedInstance: Model
    //    {
    //        if !(Static.instance != nil)
    //        {
    //            Static.instance = Model()
    //        }
    //        return Static.instance!
    //    }
    
    
    // Function that add new subject
    // _ code:String,_ name: String,_ rate: Int,_ comment: String,_ image: UIImage
    //    func addNewSub(){
    //
    //
    //        if self.code != nil && self.name != nil && self.rate != nil && self.comment != nil && self.image != nil{
    //
    //            print ("everything is not nil")
    //
    //            // Check if the manySubjects array is empty, if it is empty then add a new subject straight away,
    //            // else check if the code duplicate, if it is duplicate then POP up a duplication warning
    //            if manySubjects.count == 0 {
    //
    //                print ("manySubjects is nil")
    //
    //                let newSubject: Subject = Subject(self.code, self.name, self.rate, self.comment!, self.image)
    //                manySubjects = []
    //                manySubjects.append(newSubject)
    //
    //
    //            }else {
    //
    //                print("the manySubjects arrya is not empty")
    //
    //                for eachSubject in 0..<manySubjects.count {
    //
    //
    //                    if manySubjects[eachSubject].getSubjectInforCode() == code {
    //
    //
    //                        print("sorry the subject is already int the list")
    //
    //                        // POP up Duplicate subject warning
    //                        DuplicateSubject = true
    //
    //                    }
    //
    //                }
    //
    //                if DuplicateSubject != true {
    //                    let newSubject: Subject = Subject(self.code, self.name, self.rate, self.comment!, self.image)
    //
    //                    manySubjects.append(newSubject)
    //                }
    //
    //                DuplicateSubject = false
    //
    //            }
    //
    //
    //
    //            // Print out all the subject code in the manysubjects
    //            for eachSubject in 0..<manySubjects.count {
    //                print(manySubjects[eachSubject].getSubjectInforCode())
    //                print(manySubjects[eachSubject].getSubjectInforName())
    //                print(manySubjects[eachSubject].getSubjectInforRate())
    //            }
    //
    //        } else {
    //            print("The input can not be empty")
    //        }
    //        
    //    }
    //    
    //    func editSub(index: Int){
    //        
    //        manySubjects[index].setSubjectInforCode(self.code)
    //        manySubjects[index].setSubjectInforName(self.name)
    //        manySubjects[index].setSubjectInforRate(self.rate)
    //        manySubjects[index].setSubjectInforComment(self.comment)
    //        manySubjects[index].setSubjectInforImage(self.image)
    //    }
    
    
    
}
