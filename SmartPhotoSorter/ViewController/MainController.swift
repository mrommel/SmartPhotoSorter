//
//  MainController.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 05.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit
import Rswift

private enum Constants {
	static let textCell = "TextCell"
}

class MainController: BaseTableViewController {

	var viewModel: MainViewModel? = nil

	override func viewDidLoad() {
		super.viewDidLoad()

		self.viewModel = MainViewModel()

		self.title = R.string.localizable.mainTitle()
	}
}

// MARK: UITableViewDataSource

extension MainController {

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel?.menuItemsCount ?? 0
	}
}

// MARK: UITableViewDelegate

extension MainController {

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: Constants.textCell, for: indexPath)

		if let menuItem = self.viewModel?.menuItem(at: indexPath.row) {
			cell.imageView?.image = menuItem.image
			cell.textLabel?.text = menuItem.title
		}

		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		if let menuItem = self.viewModel?.menuItem(at: indexPath.row) {

			self.tableView.deselectRow(at: indexPath, animated: true)

			if let segue = menuItem.segue {
				self.performSegue(withIdentifier: segue, sender: self)
			}
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
}
