//
//  User.swift
//  SubjectReviewer
//
//  Created by siqi yang on 27/8/17.
//  Copyright © 2017 siqi yang. All rights reserved.
//

import Foundation
import UIKit

class User{
    
    
    var code: String! = nil
    var name: String! = nil
    var rate: Int! = nil
    var comment: String! = nil
    var image: UIImage! = #imageLiteral(resourceName: "A")//Image.image[0]
    
    var manySubjects = [Subject]()
    
    var newSubject: Subject! = nil
    
    var DuplicateSubject: Bool = false
    
    
    
    func addNewCode(code: String){
        self.code = code
        
    }
    
    func addNewName(name: String){
        self.name = name
        
        
    }
    
    func addNewRate(rate: Int){
        self.rate = rate
        
    }
    
    func addNewComment(comment: String){
        self.comment = comment
        
    }
    
    func addNewImage(image: UIImage){
        self.image = image
    }
    
    
    //Signleton
    private struct Static {
        static var instance: User?
    }
    
    class var sharedInstance: User
    {
        if !(Static.instance != nil)
        {
            Static.instance = User()
        }
        return Static.instance!
    }
    
    
    // Function that add new subject
    // _ code:String,_ name: String,_ rate: Int,_ comment: String,_ image: UIImage
    func addNewSub(){
        
        
        if self.code != nil && self.name != nil && self.rate != nil && self.comment != nil && self.image != nil{
            
            print ("everything is not nil")
            
            // Check if the manySubjects array is empty, if it is empty then add a new subject straight away,
            // else check if the code duplicate, if it is duplicate then POP up a duplication warning
            if manySubjects.count == 0 {
                
                print ("manySubjects is nil")
                
                let newSubject: Subject = Subject(self.code, self.name, self.rate, self.comment!, self.image)
                manySubjects = []
                manySubjects.append(newSubject)
                
                
            }else {
                
                print("the manySubjects arrya is not empty")
                
                for eachSubject in 0..<manySubjects.count {
                    
                    
                    if manySubjects[eachSubject].getSubjectInforCode() == code {
                        
                        
                        print("sorry the subject is already int the list")
                        
                        // POP up Duplicate subject warning
                        DuplicateSubject = true
                        
                    }
                    
                }
                
                if DuplicateSubject != true {
                    let newSubject: Subject = Subject(self.code, self.name, self.rate, self.comment!, self.image)
                    
                    manySubjects.append(newSubject)
                }
                
                DuplicateSubject = false
                
            }
            
            
            
            // Print out all the subject code in the manysubjects
            for eachSubject in 0..<manySubjects.count {
                print(manySubjects[eachSubject].getSubjectInforCode())
                print(manySubjects[eachSubject].getSubjectInforName())
                print(manySubjects[eachSubject].getSubjectInforRate())
            }
            
        } else {
            print("The input can not be empty")
        }
        
    }
    
    func editSub(index: Int){
        
        manySubjects[index].setSubjectInforCode(self.code)
        manySubjects[index].setSubjectInforName(self.name)
        manySubjects[index].setSubjectInforRate(self.rate)
        manySubjects[index].setSubjectInforComment(self.comment)
        manySubjects[index].setSubjectInforImage(self.image)
    }
    
    
    
}
