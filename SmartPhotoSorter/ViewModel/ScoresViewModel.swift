//
//  ScoresViewModel.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 07.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

struct ScoreItem {
	let title: String
	let player: String
	let score: Int
}

class ScoresViewModel {

	var scoreItems: [ScoreItem] = []

	init() {
		self.scoreItems.append(ScoreItem(title: "Spiel 1", player: "Michael", score: 45))
		self.scoreItems.append(ScoreItem(title: "Spiel 1", player: "Ines", score: 32))
		self.scoreItems.append(ScoreItem(title: "Spiel 3", player: "Michael", score: 45))
	}

	var scoreItemCount: Int {
		return self.scoreItems.count
	}

	func scoreItem(at index: Int) -> ScoreItem? {

		return self.scoreItems[index]
	}
}
