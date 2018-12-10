//
//  DataController.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 10.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import CoreData

private enum Constants {
	static let dbName = "SmartPhotoSorter"
	static let dbExtension = "momd"
	static let sqlName = "\(Constants.dbName).sqlite"
}

protocol DataControllerProtocol {

	@discardableResult func saveInBackground() -> Bool

	func createInBackground<T: NSManagedObject>() -> T?

	func fetchInBackground<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T]?

	func fetchResultInBackground<T: NSFetchRequestResult>(request: NSFetchRequest<NSFetchRequestResult>) -> [T]?

	@discardableResult func deleteInBackground<T: NSManagedObject>(object: T) -> Bool
}

class DataController: DataControllerProtocol {

	private var managedObjectContextPrivate: NSManagedObjectContext

	init(_ completionClosure: ((_ dataController: DataController) -> Void)?) {
		// This resource is the same name as your xcdatamodeld contained in your project
		let bundle = Bundle(for: DataController.self)
		guard let modelURL = bundle.url(forResource: Constants.dbName, withExtension: Constants.dbExtension) else {
			fatalError("Error loading model from bundle")
		}

		// The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
		guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
			fatalError("Error initializing mom from: \(modelURL)")
		}

		let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
		managedObjectContextPrivate = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
		managedObjectContextPrivate.persistentStoreCoordinator = psc

		let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
		queue.async {
			self.createContext()

			//The callback block is expected to complete the User Interface and therefore should be presented back on the main queue so that the user interface does not need to be concerned with which queue this call is coming from.
			DispatchQueue.main.sync {
				completionClosure?(self)
			}
		}
	}

	/// create the persistance store context
	func createContext() {
		guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
			fatalError("Unable to resolve document directory")
		}
		let storeURL = docURL.appendingPathComponent(Constants.sqlName)
		do {
			let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
			try self.managedObjectContextPrivate.persistentStoreCoordinator?.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: options)
		} catch {
			fatalError("Error migrating store: \(error as NSError)")
		}
	}
}

extension DataController {
	
	/// Save on the main object context, if there are changes
	///
	/// - Returns: true is saved false if error
	@discardableResult
	func saveInBackground() -> Bool {
		var success: ()?
		self.managedObjectContextPrivate.performAndWait {
			if self.managedObjectContextPrivate.hasChanges {
				success = try? self.managedObjectContextPrivate.save()
			}
		}

		return success != nil
	}

	/// create any NSManagedObject.
	///
	/// - Returns: The managed object T
	func createInBackground<T: NSManagedObject>() -> T? {
		var object: T?
		self.managedObjectContextPrivate.performAndWait {
			if #available(iOS 10.0, *) {
				object = T(context: self.managedObjectContextPrivate)
			} else {
				// Fallback on earlier versions

				let name = String(describing: T.self)
				guard let entityDesc = NSEntityDescription.entity(forEntityName: name, in: self.managedObjectContextPrivate) else {
					return
				}
				object = T(entity: entityDesc, insertInto: self.managedObjectContextPrivate)
			}
		}

		return object
	}

	/// execute a fetch request
	///
	/// - Parameter request: The filled fetch request
	/// - Returns: Optional list of the Elements. if nil an error occoured
	func fetchInBackground<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T]? {
		var objects: [T]?
		self.managedObjectContextPrivate.performAndWait {
			objects = try? self.managedObjectContextPrivate.fetch(request)
		}

		return objects
	}

	/// execute a fetch request
	///
	/// - Parameter request: The filled fetch request
	/// - Returns: Optional list of the Elements. if nil an error occoured
	func fetchInBackground<T: NSManagedObject, C>(request: NSFetchRequest<T>, converter: (T) -> C) -> [C]? {
		var objects: [C]?
		self.managedObjectContextPrivate.performAndWait {

			let objectsDB = try? self.managedObjectContextPrivate.fetch(request)
			objects = objectsDB?.compactMap(converter)
		}

		return objects
	}

	func fetchResultInBackground<T: NSFetchRequestResult>(request: NSFetchRequest<NSFetchRequestResult>) -> [T]? {
		var objects: [T]?
		self.managedObjectContextPrivate.performAndWait {
			objects = try! self.managedObjectContextPrivate.fetch(request) as? [T]
		}

		return objects
	}

	/// execute any NSPersistanceStoreRequest
	///
	/// - Parameter request: Request
	/// - Returns: ture is success; false if error
	func executeInBackground(request: NSPersistentStoreRequest) -> Bool {
		var success: NSPersistentStoreResult?
		self.managedObjectContextPrivate.performAndWait {
			success = try? self.managedObjectContextPrivate.execute(request)
		}
		return success != nil
	}

	/// delete a NSManagedObject from the context
	///
	/// - Parameter object: NSManagedObject
	/// - Returns: true if success; false if error
	func deleteInBackground<T: NSManagedObject>(object: T) -> Bool {
		var success: ()?
		self.managedObjectContextPrivate.performAndWait {
			self.managedObjectContextPrivate.delete(object)

			success = try? self.managedObjectContextPrivate.save()
		}
		return success != nil
	}
}
