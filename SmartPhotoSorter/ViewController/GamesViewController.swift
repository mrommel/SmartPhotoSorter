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

class GamesViewController: UITableViewController {

	let gameItems: [GameItem] = [
		GameItem(title: "Spiel 1", photos: 20),
		GameItem(title: "Spiel 2", photos: 32),
		GameItem(title: "Spiel 3", photos: 12)
	]

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
		//let menuItem = scoreItems[indexPath.row]

		/*if let segue = scoreItems.segue {
		self.performSegue(withIdentifier: segue, sender: self)
		}*/
	}

	override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return nil
	}
}
