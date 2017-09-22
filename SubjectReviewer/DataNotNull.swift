//
//  DataNotNull.swift
//  SubjectReviewer
//
//  Created by siqi yang on 22/9/17.
//  Copyright © 2017 siqi yang. All rights reserved.
//

import Foundation
import UIKit


class DataNotNull{
    
    //MARK: - Properties
    var model = Model.sharedInstance
    var code: String = "COSC2472"
    var name: String = "iPhone Software Engineering"
    var image: UIImage = #imageLiteral(resourceName: "I")
    var rate: Int = 5
    var comment: String = "iPhone Software Engineering is concerned with the development of applications on the Apple iPhone and iPod Touch platforms. Current SWIFT and the Apple iOS SDK will be used as a basis for teaching programming techniques and design patterns related to the development of standalone applications and mobile portals to enterprise and m-commerce systems."
    
    func setData(){
        model.addNewCode(code: self.code)
        model.addNewName(name: self.name)
        model.addNewImage(image: self.image)
        model.addNewRate(rate: self.rate)
        model.addNewComment(comment: self.comment)
        model.addNewSub()
    }
}
