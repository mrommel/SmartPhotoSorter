//
//  GameViewModel.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 06.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation
import SKPhotoBrowser

struct GameItem {

	let photo: SKPhotoProtocol
	let order: Int
}

class GameViewModel {

	//let name: String
	private var items = [GameItem]()
	let player: Player?
	let game: Game?

	init(game: Game, player: Player) {

		self.game = game
		self.player = player

		self.items = self.createStorage()
	}

	var pageTitle: String {
		return self.game?.name ?? R.string.localizable.gameTitleNoGame()
	}

	func amountOfImages() -> Int {
		return 10
	}

	func score() -> Int {

		let orders = self.items.map { return $0.order }

		let scoreCalculator = ScoreCalculator()
		let score = scoreCalculator.calculateScore(of: orders)

		return score
	}

	func createStorage() -> [GameItem] {

		let amountOfImages = self.amountOfImages()

		return (0..<amountOfImages).map { (i: Int) -> GameItem in

			// FIXME: read from game
			let photo = SKPhoto.photoWithImage(UIImage(named: "image\(i % 10)")!)
			photo.caption = R.string.localizable.gameDetailCaption()
			return GameItem(photo: photo, order: i)
		}
	}

	var allPhotos: [SKPhotoProtocol] {

		return self.items.map { return $0.photo }
	}

	func image(at index: Int) -> UIImage {

		return self.items[index].photo.underlyingImage
	}

	func swap(source: Int, destination: Int) {

		self.items.swapAt(source, destination)
	}
}
