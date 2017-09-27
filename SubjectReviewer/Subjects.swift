//
//  Subjects.swift
//  SubjectReviewer
//
//  Created by siqi yang on 27/8/17.
//  Copyright © 2017 siqi yang. All rights reserved.
//

import Foundation
import UIKit

class Subjects{
    private var subjectInforCode: String
    
    private var subjectInforName: String
    
    private var subjectInforRate:Int
    
    private var subjectInforComment: String
    private var subjectInforImage: UIImage
    
    
    init(_ subjectInforCode: String,_ subjectInforName: String,_ subjectInforRate: Int,_ subjectInforComment: String,_ subjectInforImage: UIImage){
        self.subjectInforCode = subjectInforCode
        self.subjectInforName = subjectInforName
        self.subjectInforRate = subjectInforRate
        self.subjectInforComment = subjectInforComment
        self.subjectInforImage = subjectInforImage
    }
    
    
    
    func setSubjectInforCode(_ code: String){
        self.subjectInforCode = code
    }
    
    func setSubjectInforName(_ name: String){
        self.subjectInforName = name
    }
    
    func setSubjectInforRate(_ rate: Int){
        self.subjectInforRate = rate
    }
    
    func setSubjectInforComment(_ comment: String){
        self.subjectInforComment = comment
    }
    
    func setSubjectInforImage(_ image: UIImage){
        self.subjectInforImage = image
    }
    
    func getSubjectInforCode()-> String{
        return self.subjectInforCode
    }
    
    func getSubjectInforName()-> String{
        return self.subjectInforName
    }
    
    func getSubjectInforRate()-> Int{
        return self.subjectInforRate
    }
    
    func getSubjectInforComment()-> String{
        return self.subjectInforComment
    }
    
    func getSubjectInforImage()-> UIImage{
        return self.subjectInforImage
    }
    
}



