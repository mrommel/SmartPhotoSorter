//
//  ScoresViewController.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 05.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit
import Rswift

class ScoresViewController: BaseTableViewController {

	let viewModel = ScoresViewModel()

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
		return self.viewModel.scoreItemCount
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
		if let scoreItem = self.viewModel.scoreItem(at: indexPath.row) {
			cell.textLabel?.text = "\(scoreItem.title) - \(scoreItem.player) - \(scoreItem.score)"
		}

		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//let menuItem = scoreItems[indexPath.row]

		/*if let segue = scoreItems.segue {
			self.performSegue(withIdentifier: segue, sender: self)
		}*/

		self.tableView.deselectRow(at: indexPath, animated: true)
	}
}
