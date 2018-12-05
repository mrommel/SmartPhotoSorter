//
//  MainController.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 05.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit
import Rswift

struct MenuItem {
	let title: String
	let segue: String?
}

private enum Constants {
	static let showGames = "showGames"
	static let showScores = "showScores"
	static let showOptions = "showOptions"
}

class MainController: UITableViewController {

	let menuItems: [MenuItem] = [
		MenuItem(title: R.string.localizable.mainMenuGames(), segue: Constants.showGames),
		MenuItem(title: R.string.localizable.mainMenuScores(), segue: Constants.showScores),
		MenuItem(title: R.string.localizable.mainMenuOptions(), segue: Constants.showOptions)
	]

	override func viewDidLoad() {
		super.viewDidLoad()

		self.title = R.string.localizable.mainTitle() 
	}
}

// MARK: UITableViewDataSource

extension MainController {

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return menuItems.count
	}
}

// MARK: UITableViewDelegate

extension MainController {

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath)
		let menuItem = menuItems[indexPath.row]
		cell.textLabel?.text = "\(menuItem.title)"

		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let menuItem = menuItems[indexPath.row]

		if let segue = menuItem.segue {
			self.performSegue(withIdentifier: segue, sender: self)
		}
	}

	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

		let headerImage: UIImage = UIImage(named: "Splash")!
		let headerView = UIImageView(image: headerImage)
		headerView.contentMode = .scaleAspectFit
		return headerView
	}

	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 120
	}

	override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return nil
	}
}

