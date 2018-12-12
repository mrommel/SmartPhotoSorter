//
//  ScoresViewModel.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 07.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation
import Rswift

class ScoreItem {

	let player: String
	let date: Date?
	let score: Int

	init(score: Score) {
		self.date = score.date! as Date
		self.player = score.player?.name ?? R.string.localizable.scoresErrorNoPlayer()
		self.score = Int(score.value)
	}
}

class ScoreGameItem {

	let title: String
	var scores: [ScoreItem] = []

	init(gameTitle: String) {
		self.title = gameTitle
	}

	func add(score: Score) {
		let scoreItem = ScoreItem(score: score)
		self.scores.append(scoreItem)
	}
}

class ScoresViewModel {

	var scoreGameItems: [ScoreGameItem] = []

	var gameUseCase: GameUseCaseProtocol?

	init() {

		self.gameUseCase = AppCore.shared.gameUseCase

		self.populateScores()
	}

	func populateScores() {

		guard let scores = self.gameUseCase?.scores() else {
			return
		}

		for score in scores {

			var scoreGameItem = self.scoreGameItems.first(where: { $0.title == score.game?.name })

			if scoreGameItem == nil {
				scoreGameItem = ScoreGameItem(gameTitle: score.game?.name ?? R.string.localizable.gamesErrorNoGame())

				self.scoreGameItems.append(scoreGameItem!)
			}

			scoreGameItem?.add(score: score)
		}
	}

	var scoreGameItemCount: Int {
		return self.scoreGameItems.count
	}

	func sectionTitle(at index: Int) -> String {

		let section = self.scoreGameItems[index]

		return section.title
	}

	func scoreItemCount(for section: Int) -> Int {
		return self.scoreGameItems[section].scores.count
	}

	func scoreItem(at indexPath: IndexPath) -> ScoreItem? {

		return self.scoreGameItems[indexPath.section].scores[indexPath.row]
	}
}
