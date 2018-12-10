//
//  Game+CoreDataProperties.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 06.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var name: String?
    @NSManaged public var scores: Score?
	@NSManaged public var photos: NSSet?

}

// MARK: Generated accessors for photos
extension Game {

	@objc(addPhotosObject:)
	@NSManaged public func addToPhotos(_ value: Photo)

	@objc(removePhotosObject:)
	@NSManaged public func removeFromPhotos(_ value: Photo)

	@objc(addPhotos:)
	@NSManaged public func addToPhotos(_ values: NSSet)

	@objc(removePhotos:)
	@NSManaged public func removeFromPhotos(_ values: NSSet)

}

