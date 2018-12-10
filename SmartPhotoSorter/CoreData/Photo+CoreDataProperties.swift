//
//  Photo+CoreDataProperties.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 06.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

extension Photo {

	@nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
		return NSFetchRequest<Photo>(entityName: "Photo")
	}

	@NSManaged public var imageData: NSData?
	@NSManaged public var name: String?
	@NSManaged public var order: Int32
	@NSManaged public var game: Game?

}

extension Photo {

	func image() -> UIImage {

		return UIImage(data: self.imageData! as Data) ?? UIImage()
	}
}
