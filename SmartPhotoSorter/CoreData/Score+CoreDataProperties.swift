//
//  Score+CoreDataProperties.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 06.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//
//

import Foundation
import CoreData


extension Score {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Score> {
        return NSFetchRequest<Score>(entityName: "Score")
    }

    @NSManaged public var value: Int32
    @NSManaged public var date: NSDate?
    @NSManaged public var player: Player?
    @NSManaged public var game: Game?

}
