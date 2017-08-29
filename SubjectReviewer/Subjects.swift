//
//  Subjects.swift
//  SubjectReviewer
//
//  Created by siqi yang on 27/8/17.
//  Copyright © 2017 siqi yang. All rights reserved.
//

import Foundation

class Subjects{
    private var subjectInforCode: String
//    {
//        set(code) {
//            self.subjectInforCode = code
//        }
//        get {
//            return self.subjectInforComment
//        }
//    }
    private var subjectInforName: String
//    {
//        set(name) {
//            self.subjectInforName = name
//        }
//        get{
//            return self.subjectInforName
//        }
//    }
    private var subjectInforRate:Int!
//    {
//        set(rate) {
//            self.subjectInforRate = rate
//        }
//        get{
//            return self.subjectInforRate
//        }
//    }
    private var subjectInforComment: String!
//    {
//        set(comment) {
//            self.subjectInforComment = comment
//        }
//        get {
//            return self.subjectInforComment
//        }
//    }
    
    init(_ subjectInforCode: String,_ subjectInforName: String){
        self.subjectInforCode = subjectInforCode
        self.subjectInforName = subjectInforName
    }
    
    
    func setSubjectInforCode(_ code: String){
        self.subjectInforCode = code
    }
    
    func setSubjectInforName(_ name: String){
        self.subjectInforName = name
    }
    
    func setSubjectInforRate(_ rate: Int!){
        self.subjectInforRate = rate
    }
    
    func setSubjectInforComment(_ comment: String!){
        self.subjectInforComment = comment
    }
    
    func getSubjectInforCode()-> String{
        return self.subjectInforCode
    }
    
    func getSubjectInforName()-> String{
        return self.subjectInforName
    }
    
    func getSubjectInforRate()-> String{
        return "\(self.subjectInforRate!)"
    }
    
    func getSubjectInforComment()-> String{
        return self.subjectInforComment
    }

}



