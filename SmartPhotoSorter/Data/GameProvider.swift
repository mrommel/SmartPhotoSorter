//
//  GameProvider.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 06.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit
import CoreData

class GameProvider {

	// player

	@discardableResult
	func players() -> [Player]? {

		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }

		let managedContext = appDelegate.persistentContainer.viewContext

		let playerFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
		playerFetch.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true)]
		let players = try! managedContext.fetch(playerFetch)

		return players as? [Player]
	}

	func playerBy(index: Int) -> Player? {

		let players = self.players()

		return players?[index]
	}

	@discardableResult
	func createPlayer(with name: String) -> Player? {

		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			print("Could not get app delegate.")
			return nil
		}

		let managedContext = appDelegate.persistentContainer.viewContext

		let playerEntity = NSEntityDescription.entity(forEntityName: "Player", in: managedContext)!

		let player = NSManagedObject(entity: playerEntity, insertInto: managedContext)
		player.setValue(name, forKeyPath: "name")

		do {
			try managedContext.save()
			return player as? Player
		} catch let error as NSError {
			print("Could not save. \(error), \(error.userInfo)")
		}

		return nil
	}

	// games

	@discardableResult
	func games() -> [Game]? {

		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }

		let managedContext = appDelegate.persistentContainer.viewContext

		let gameFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
		gameFetch.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true)]
		let games = try! managedContext.fetch(gameFetch)

		return games as? [Game]
	}

	@discardableResult
	func gameBy(name: String) -> Game? {

		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }

		let managedContext = appDelegate.persistentContainer.viewContext

		let gameFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
		gameFetch.fetchLimit = 1
		gameFetch.predicate = NSPredicate(format: "name = %@", name)
		let games = try! managedContext.fetch(gameFetch)

		let game: Game? = games.first as? Game

		return game
	}

	@discardableResult
	func gameBy(index: Int) -> Game? {

		let games = self.games()

		return games?[index]
	}

	@discardableResult
	func createGame(with name: String) -> Game? {

		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			print("Could not get app delegate.")
			return nil
		}

		let managedContext = appDelegate.persistentContainer.viewContext

		let gameEntity = NSEntityDescription.entity(forEntityName: "Game", in: managedContext)!

		let game = NSManagedObject(entity: gameEntity, insertInto: managedContext)
		game.setValue(name, forKeyPath: "name")

		do {
			try managedContext.save()
			return game as? Game
		} catch let error as NSError {
			print("Could not save. \(error), \(error.userInfo)")
		}

		return nil
	}

	// scores

	func scores() -> [Score]? {

		return nil
	}

	func createScore() {

	}
}
