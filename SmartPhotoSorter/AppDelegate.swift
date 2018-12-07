//
//  AppDelegate.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 05.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit
import CoreData
import Rswift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		// init data, if not already there
		if self.needData() {
			self.initData()
		}

		return true
	}

	func needData() -> Bool {

		let provider = GameProvider()
		guard let games = provider.games() else {
			return true
		}

		if games.count == 0 {
			return true
		}

		return false
	}

	func initData() {

		let provider = GameProvider()

		// players
		provider.createPlayer(with: "Michael")
		provider.createPlayer(with: "Ines")
		provider.createPlayer(with: "Annalena")
		provider.createPlayer(with: "Marcel")

		// game "holiday"
		let holiday = provider.createGame(with: "Urlaub")
		holiday?.add(photo: R.image.image0(), and: "Image 0", with: 0)
		holiday?.add(photo: R.image.image1(), and: "Image 1", with: 1)
		holiday?.add(photo: R.image.image2(), and: "Image 2", with: 2)
		holiday?.add(photo: R.image.image3(), and: "Image 3", with: 3)

		// game "childhood"
		let childhood = provider.createGame(with: "Kindheit")
		childhood?.add(photo: R.image.image4(), and: "Image 4", with: 4)
		childhood?.add(photo: R.image.image5(), and: "Image 5", with: 5)
		childhood?.add(photo: R.image.image6(), and: "Image 6", with: 6)
		childhood?.add(photo: R.image.image7(), and: "Image 7", with: 7)
		childhood?.add(photo: R.image.image8(), and: "Image 8", with: 8)
		childhood?.add(photo: R.image.image9(), and: "Image 9", with: 9)
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
		// Saves changes in the application's managed object context before the application terminates.
		self.saveContext()
	}

	// MARK: - Core Data stack

	lazy var persistentContainer: NSPersistentContainer = {
	    /*
	     The persistent container for the application. This implementation
	     creates and returns a container, having loaded the store for the
	     application to it. This property is optional since there are legitimate
	     error conditions that could cause the creation of the store to fail.
	    */
	    let container = NSPersistentContainer(name: "SmartPhotoSorter")
	    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
	        if let error = error as NSError? {
	            // Replace this implementation with code to handle the error appropriately.
	            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	             
	            /*
	             Typical reasons for an error here include:
	             * The parent directory does not exist, cannot be created, or disallows writing.
	             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
	             * The device is out of space.
	             * The store could not be migrated to the current model version.
	             Check the error message to determine what the actual problem was.
	             */
	            fatalError("Unresolved error \(error), \(error.userInfo)")
	        }
	    })
	    return container
	}()

	// MARK: - Core Data Saving support

	func saveContext () {
	    let context = persistentContainer.viewContext
	    if context.hasChanges {
	        do {
	            try context.save()
	        } catch {
	            // Replace this implementation with code to handle the error appropriately.
	            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	            let nserror = error as NSError
	            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
	        }
	    }
	}

}

