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
    @NSManaged public var photos: Photo?

}

extension Game {

	@discardableResult
	func add(photo image: UIImage?, and name: String, with order: Int) -> Photo? {

		guard let image = image else {
			print("Nil for image is not allowed.")
			return nil
		}

		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			print("Could not get app delegate.")
			return nil
		}

		let managedContext = appDelegate.persistentContainer.viewContext

		let photoEntity = NSEntityDescription.entity(forEntityName: "Photo", in: managedContext)!

		let photo = NSManagedObject(entity: photoEntity, insertInto: managedContext)
		photo.setValue(name, forKeyPath: "name")
		photo.setValue(image.pngData(), forKeyPath: "image")
		photo.setValue(self, forKeyPath: "game")
		photo.setValue(order, forKeyPath: "order")

		return photo as? Photo
	}
}
