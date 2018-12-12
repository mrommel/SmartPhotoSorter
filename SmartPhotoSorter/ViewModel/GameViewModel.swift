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

	private var items = [GameItem]()
	var viewController: GameViewController? = nil
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

		return self.game?.photos?.count ?? 0
	}

	func score() -> Int {

		let orders = self.items.map { return $0.order }

		let scoreCalculator = ScoreCalculator()
		let score = scoreCalculator.calculateScore(of: orders)

		return score
	}

	func createStorage() -> [GameItem] {

		let amountOfImages = self.amountOfImages()
		guard let allPhotos = self.game?.photos?.allObjects as? [Photo] else {
			return []
		}

		return (0..<amountOfImages).map { (i: Int) -> GameItem in

			// read from game
			let photo = SKPhoto.photoWithImage(allPhotos[i].image())
			photo.caption = R.string.localizable.gameDetailCaption()
			return GameItem(photo: photo, order: Int(allPhotos[i].order))
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

	func finishGame() {

		let scoreValue = self.score()
		print("finishGame: \(scoreValue)")

		// add new score entry
		AppCore.shared.gameUseCase.createScore(for: self.game, and: self.player, with: scoreValue)

		// go to main menu
		self.viewController?.navigationController?.popViewController(animated: true)

		// go to scores list
		let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
		if let scoresViewController = storyBoard.instantiateViewController(withIdentifier: "scoresViewController") as? ScoresViewController {
			self.viewController?.navigationController?.pushViewController(scoresViewController, animated: true)
		}
	}
}
