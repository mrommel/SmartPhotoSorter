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

	func needData() -> Bool {

		guard let games = games() else {
			return true
		}

		if games.count == 0 {
			return true
		}

		return false
	}

	func initData() {

		// players
		self.createPlayer(with: "Michael")
		self.createPlayer(with: "Ines")
		self.createPlayer(with: "Annalena")
		self.createPlayer(with: "Marcel")

		// game "holiday"
		let holiday = self.createGame(with: "Urlaub")
		holiday?.add(photo: R.image.image0(), and: "Image 0", with: 0)
		holiday?.add(photo: R.image.image1(), and: "Image 1", with: 1)
		holiday?.add(photo: R.image.image2(), and: "Image 2", with: 2)
		holiday?.add(photo: R.image.image3(), and: "Image 3", with: 3)

		// game "childhood"
		let childhood = self.createGame(with: "Kindheit")
		childhood?.add(photo: R.image.image4(), and: "Image 4", with: 4)
		childhood?.add(photo: R.image.image5(), and: "Image 5", with: 5)
		childhood?.add(photo: R.image.image6(), and: "Image 6", with: 6)
		childhood?.add(photo: R.image.image7(), and: "Image 7", with: 7)
		childhood?.add(photo: R.image.image8(), and: "Image 8", with: 8)
		childhood?.add(photo: R.image.image9(), and: "Image 9", with: 9)
	}

	func reset() {

		self.deleteScores()
		self.deletePlayers()
		self.deleteGames()
	}
}

// player

extension GameProvider {

	@discardableResult
	func players() -> [Player]? {

		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }

		let managedContext = appDelegate.persistentContainer.viewContext

		let playerFetch: NSFetchRequest<Player> = Player.fetchRequest()
		playerFetch.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true)]
		let players = try! managedContext.fetch(playerFetch)

		return players
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

	func deletePlayers() {

		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			print("Could not get app delegate.")
			return
		}

		let managedContext = appDelegate.persistentContainer.viewContext

		let playerFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
		let request = NSBatchDeleteRequest(fetchRequest: playerFetch)

		do {
			try managedContext.execute(request)
			try managedContext.save()
		} catch {
			print("There was an error")
		}
	}
}

// games

extension GameProvider {

	@discardableResult
	func games() -> [Game]? {

		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }

		let managedContext = appDelegate.persistentContainer.viewContext

		let gameFetch: NSFetchRequest<Game> = Game.fetchRequest()
		gameFetch.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true)]
		let games = try! managedContext.fetch(gameFetch)

		return games
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

	func deleteGames() {

		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			print("Could not get app delegate.")
			return
		}

		let managedContext = appDelegate.persistentContainer.viewContext

		let gameFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
		let request = NSBatchDeleteRequest(fetchRequest: gameFetch)

		do {
			try managedContext.execute(request)
			try managedContext.save()
		} catch {
			print("There was an error")
		}
	}
}

// scores

extension GameProvider {

	func scores() -> [Score]? {

		return nil
	}

	func createScore() {

	}

	func deleteScores() {

	}
}
