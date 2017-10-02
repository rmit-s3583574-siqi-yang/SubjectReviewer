//
//  Subjects+CoreDataProperties.swift
//  SubjectReviewer
//
//  Created by siqi yang on 1/10/17.
//  Copyright © 2017 siqi yang. All rights reserved.
//

import Foundation
import CoreData


extension Subjects {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subjects> {
        return NSFetchRequest<Subjects>(entityName: "Subjects")
    }

    @NSManaged public var code: String?
    @NSManaged public var comment: String?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var rate: Int16

}
