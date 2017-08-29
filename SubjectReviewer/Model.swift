//
//  Model.swift
//  SubjectReviewer
//
//  Created by siqi yang on 27/8/17.
//  Copyright © 2017 siqi yang. All rights reserved.
//

import Foundation

class Model{
    
    
    var manySubjects:[Subjects] = []
    var code: String! = nil
    var name: String! = nil
    var rate: String! = nil
    var comment: String! = nil
    
    var newSubject: Subjects! = nil

    //var error: Bool = false

    
    func addNewCode(code: String){
        self.code = code

    }
    
    func addNewName(name: String){
        self.name = name


    }
    
    func addNewSub(){
        if self.code != nil && self.name != nil {
            let newSubject: Subjects = Subjects(self.code, self.name)
             manySubjects.append(newSubject)
            newSubject.setSubjectInforRate(Int(self.rate!))
            newSubject.setSubjectInforComment(self.comment!)
            print(manySubjects[0].getSubjectInforCode())
            print(manySubjects[0].getSubjectInforName())
            print(manySubjects[0].getSubjectInforRate())
            print(manySubjects[0].getSubjectInforComment())
        }
    }
    
    func addNewRate(rate: String){
        self.rate = rate

    }
    
    func addNewComment(comment: String){
        self.comment = comment

    }
    
    func editSub(index: Int){
        
        manySubjects[index].setSubjectInforCode(self.code)
        manySubjects[index].setSubjectInforName(self.name)
        manySubjects[index].setSubjectInforRate(Int(self.rate))
        manySubjects[index].setSubjectInforComment(self.comment)
    }
    
    

}
