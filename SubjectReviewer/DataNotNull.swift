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
    
    var user = User.sharedInstance
    var code: String = "COSC2472"
    var name: String = "iPhone Software Engineering"
    var image: UIImage = #imageLiteral(resourceName: "A")//Image.image[8]
    var rate: Int = 5
    var comment: String = "iPhone Software Engineering is concerned with the development of applications on the Apple iPhone and iPod Touch platforms. Current SWIFT and the Apple iOS SDK will be used as a basis for teaching programming techniques and design patterns related to the development of standalone applications and mobile portals to enterprise and m-commerce systems."
    
    func setData(){
        user.addNewCode(code: self.code)
        user.addNewName(name: self.name)
        user.addNewImage(image: self.image)
        user.addNewRate(rate: self.rate)
        user.addNewComment(comment: self.comment)
        user.addNewSub()
    }
}
