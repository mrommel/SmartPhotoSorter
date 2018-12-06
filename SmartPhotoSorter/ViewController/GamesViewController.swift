//
//  GamesViewController.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 05.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit

struct GameItem {
	let title: String
	let photos: Int

	// maybe add photos here
}

private enum Constants {
	static let startGame = "startGame"
}

class GamesViewController: UITableViewController {

	let gameItems: [GameItem] = [
		GameItem(title: "Spiel 1", photos: 20),
		GameItem(title: "Spiel 2", photos: 32),
		GameItem(title: "Spiel 3", photos: 12)
	]

	var game: Game? = nil

	override func viewDidLoad() {
		super.viewDidLoad()

		self.title = "Games"
	}
}

// MARK: UITableViewDataSource

extension GamesViewController {

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return gameItems.count
	}
}

// MARK: UITableViewDelegate

extension GamesViewController {

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath)
		let gameItem = gameItems[indexPath.row]
		cell.textLabel?.text = "\(gameItem.title) - \(gameItem.photos)"

		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		let nameOfGame = "abc" // FIXME

		let alert = UIAlertController(title: "Name", message: "Please enter your name", preferredStyle: .alert)

		let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in

			guard let textField = alert.textFields?.first, let nameOfPlayer = textField.text else {
				return
			}

			self.game = Game(name: nameOfGame, player: nameOfPlayer)

			self.performSegue(withIdentifier: Constants.startGame, sender: self)
		}

		let cancelAction = UIAlertAction(title: "Cancel",
										 style: .cancel)

		alert.addTextField()

		alert.addAction(saveAction)
		alert.addAction(cancelAction)

		present(alert, animated: true)
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

		if segue.identifier == Constants.startGame {

			let destination = segue.destination as? PlayViewController
			destination?.game = self.game
		}
	}

	override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return nil
	}
}
