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
	let image: UIImage?
	let segue: String?
}

private enum Constants {
	static let showGames = "showGames"
	static let showScores = "showScores"
	static let showOptions = "showOptions"
}

class MainController: UITableViewController {

	let menuItems: [MenuItem] = [
		MenuItem(title: R.string.localizable.mainMenuGames(), image: R.image.rocket(), segue: Constants.showGames),
		MenuItem(title: R.string.localizable.mainMenuScores(), image: R.image.score(), segue: Constants.showScores),
		MenuItem(title: R.string.localizable.mainMenuOptions(), image: R.image.options(), segue: Constants.showOptions)
	]

	let theme = ThemeManager.currentTheme()

	override func viewDidLoad() {
		super.viewDidLoad()

		self.view.backgroundColor = theme.backgroundColor

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

		cell.imageView?.image = menuItem.image
		cell.textLabel?.text = menuItem.title

		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let menuItem = menuItems[indexPath.row]

		if let segue = menuItem.segue {
			self.performSegue(withIdentifier: segue, sender: self)
		}
	}

	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

		let headerImage: UIImage = R.image.splash()!
		let headerView = UIImageView(image: headerImage)
		headerView.contentMode = .scaleAspectFit
		return headerView
	}

	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 180
	}

	override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return nil
	}
}

