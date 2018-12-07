//
//  ScoresViewController.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 05.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit
import Rswift

struct ScoreItem {
	let title: String
	let player: String
	let score: Int
}

class ScoresViewController: BaseTableViewController {

	let scoreItems: [ScoreItem] = [
		ScoreItem(title: "Spiel 1", player: "Michael", score: 45),
		ScoreItem(title: "Spiel 1", player: "Ines", score: 32),
		ScoreItem(title: "Spiel 3", player: "Michael", score: 45)
	]

	override func viewDidLoad() {
		super.viewDidLoad()

		self.title = "Scores"
	}
}

// MARK: UITableViewDataSource

extension ScoresViewController {

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return scoreItems.count
	}
}

// MARK: UITableViewDelegate

extension ScoresViewController {

	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

		let headerImage: UIImage = R.image.score()!
		let headerView = UIImageView(image: headerImage)
		headerView.contentMode = .scaleAspectFit
		return headerView
	}

	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 180
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath)
		let menuItem = scoreItems[indexPath.row]
		cell.textLabel?.text = "\(menuItem.title) - \(menuItem.player) - \(menuItem.score)"

		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//let menuItem = scoreItems[indexPath.row]

		/*if let segue = scoreItems.segue {
			self.performSegue(withIdentifier: segue, sender: self)
		}*/

		tableView.deselectRow(at: indexPath, animated: true)
	}

	override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return nil
	}
}
