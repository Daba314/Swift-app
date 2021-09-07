//
//  News+CoreDataProperties.swift
//  
//
//  Created by user198847 on 8/1/21.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var labelNews: String?
    @NSManaged public var pictures: Data?

}
