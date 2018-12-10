//
//  GameUserCase.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 10.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

protocol GameUseCaseProtocol {

	func isInitialized() -> Bool

	func games() -> [Game]?
	func game(by index: Int) -> Game?

	func players() -> [Player]?
	func player(by index: Int) -> Player?

	func reset()
	func populate()
}

class GameUserCase: GameUseCaseProtocol {

	private let dataProvider: DataProviderProtocol

	init(dataProvider: DataProviderProtocol) {
		self.dataProvider = dataProvider
	}

	func isInitialized() -> Bool {

		guard let games = games() else {
			return false
		}

		if games.count == 0 {
			return false
		}

		return true
	}

	func games() -> [Game]? {
		
		return self.dataProvider.games()
	}

	func game(by index: Int) -> Game? {

		return self.dataProvider.game(by: index)
	}

	func players() -> [Player]? {

		return self.dataProvider.players()
	}

	func player(by index: Int) -> Player? {

		return self.dataProvider.player(by: index)
	}

	func reset() {

		return self.dataProvider.reset()
	}

	func populate() {

		return self.dataProvider.populate()
	}
}
