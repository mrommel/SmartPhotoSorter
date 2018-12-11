//
//  GamesViewModel.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 06.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit
import Rswift

struct GamesItem {

	let title: String
}

struct PlayerItem {

	let name: String
}

struct GameOption {

	var gameSelection: Int = -1
	var playerSelection: Int = -1
}

class GamesViewModel: NSObject {

	var gameItems: [GamesItem] = []
	var playerItems: [PlayerItem] = []
	var gameOption: GameOption = GameOption()

	var gameUseCase: GameUseCaseProtocol?

	override init() {
		super.init()

		self.gameUseCase = AppCore.shared.gameUseCase

		self.populateGames()
		self.populatePlayers()
	}

	func pageTitle() -> String {

		return R.string.localizable.gamesTitle()
	}

	func populateGames() {

		if let games = self.gameUseCase?.games() {
			for game in games {
				self.gameItems.append(GamesItem(title: game.name ?? R.string.localizable.gamesErrorNoGame()))
			}
		}
	}

	var gamesCount: Int {
		return self.gameItems.count
	}

	func item(at index: Int) -> GamesItem {
		return self.gameItems[index]
	}

	func selectGameItem(at index: Int) {
		self.gameOption.gameSelection = index
	}

	func createGameViewModel() -> GameViewModel? {

		if let game = gameUseCase?.game(by: self.gameOption.gameSelection),
			let player = gameUseCase?.player(by: self.gameOption.playerSelection) {

			let gameViewModel = GameViewModel(game: game, player: player)

			return gameViewModel
		}

		return nil
	}
}

// MARK: UIPickerViewDataSource

extension GamesViewModel: UIPickerViewDataSource {

	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}

	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return self.playerItems.count
	}
}

// MARK: Player functions

// for player picker
extension GamesViewModel {

	func populatePlayers() {

		if let players = gameUseCase?.players() {
			for player in players {
				self.playerItems.append(PlayerItem(name: player.name ?? R.string.localizable.scoresErrorNoPlayer()))
			}
		}
	}

	func playerName(at index: Int) -> String {
		return self.playerItems[index].name
	}

	func selectPlayerItem(at index: Int) {
		self.gameOption.playerSelection = index
	}
}
