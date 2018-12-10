//
//  DataProvider.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 06.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit
import CoreData

protocol DataProviderProtocol {

	func games() -> [Game]?
	func game(by index: Int) -> Game?

	func players() -> [Player]?
	func player(by index: Int) -> Player?

	func reset()
	func populate()
}

class DataProvider: DataProviderProtocol {

	private let dataController: DataControllerProtocol

	init(dataController: DataControllerProtocol) {
		self.dataController = dataController
	}

	func populate() {

		// players
		self.createPlayer(with: "Michael")
		self.createPlayer(with: "Ines")
		self.createPlayer(with: "Annalena")
		self.createPlayer(with: "Marcel")

		// game "holiday"
		let holiday = self.createGame(with: "Urlaub")
		self.add(photo: R.image.image0(), and: "Image 0", with: 0, to: holiday)
		self.add(photo: R.image.image1(), and: "Image 1", with: 1, to: holiday)
		self.add(photo: R.image.image2(), and: "Image 2", with: 2, to: holiday)
		self.add(photo: R.image.image3(), and: "Image 3", with: 3, to: holiday)

		// game "childhood"
		let childhood = self.createGame(with: "Kindheit")
		self.add(photo: R.image.image4(), and: "Image 4", with: 4, to: childhood)
		self.add(photo: R.image.image5(), and: "Image 5", with: 5, to: childhood)
		self.add(photo: R.image.image6(), and: "Image 6", with: 6, to: childhood)
		self.add(photo: R.image.image7(), and: "Image 7", with: 7, to: childhood)
		self.add(photo: R.image.image8(), and: "Image 8", with: 8, to: childhood)
		self.add(photo: R.image.image9(), and: "Image 9", with: 9, to: childhood)
	}

	func reset() {

		self.deleteScores()
		self.deletePlayers()
		self.deleteGames()
	}
}

// player

extension DataProvider {

	@discardableResult
	func players() -> [Player]? {

		return dataController.fetchInBackground(request: Player.fetchRequest())
	}

	func player(by index: Int) -> Player? {

		let players = self.players()

		return players?[index]
	}

	@discardableResult
	func createPlayer(with name: String) -> Player? {

		let player: Player? = dataController.createInBackground()
		player?.name = name

		self.dataController.saveInBackground()

		return player
	}

	func deletePlayers() {

		for player in self.players() ?? [] {
			_ = dataController.deleteInBackground(object: player)
		}
	}
}

// games

extension DataProvider {

	@discardableResult
	func games() -> [Game]? {

		return dataController.fetchInBackground(request: Game.fetchRequest())
	}

	@discardableResult
	func game(by index: Int) -> Game? {

		let games = self.games()

		return games?[index]
	}

	@discardableResult
	func createGame(with name: String) -> Game? {

		let game: Game? = self.dataController.createInBackground()
		game?.name = name

		self.dataController.saveInBackground()

		return game
	}

	func deleteGames() {

		for game in self.games() ?? [] {

			/*for photo in game.photos {
				_ = dataController.deleteInBackground(object: photo)
			}*/

			_ = dataController.deleteInBackground(object: game)
		}
	}
}

// photos

extension DataProvider {

	@discardableResult
	func add(photo image: UIImage?, and name: String, with order: Int32, to game: Game?) -> Photo? {

		guard let image = image else {
			print("Nil for image is not allowed.")
			return nil
		}

		let photo: Photo? = self.dataController.createInBackground()
		photo?.name = name
		photo?.imageData = image.pngData() as NSData?
		photo?.game = game
		photo?.order = order

		if let photoToAdd = photo {
			game?.addToPhotos(photoToAdd)
		}

		self.dataController.saveInBackground()

		return photo
	}
}

// scores

extension DataProvider {

	func scores() -> [Score]? {

		return nil
	}

	func createScore() {

	}

	func deleteScores() {

	}
}
