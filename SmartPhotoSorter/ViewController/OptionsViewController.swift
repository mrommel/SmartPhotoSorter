//
//  OptionsViewController.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 07.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit
import Rswift

class OptionsViewController: UITableViewController {

	let viewModel: OptionsViewModel = OptionsViewModel()
	let theme = ThemeManager.currentTheme()

	override func viewDidLoad() {
		super.viewDidLoad()

		self.view.backgroundColor = theme.backgroundColor

		self.title = "Options"
	}
}

// MARK: UITableViewDataSource

extension OptionsViewController {

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel.optionsItems.count
	}
}

// MARK: UITableViewDelegate

extension OptionsViewController {

	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

		let headerImage: UIImage = R.image.options()!
		let headerView = UIImageView(image: headerImage)
		headerView.contentMode = .scaleAspectFit
		return headerView
	}

	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 180
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath)
		let optionItem = self.viewModel.item(at: indexPath.row)

		cell.imageView?.image = optionItem.image
		cell.textLabel?.text = optionItem.title

		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		let optionItem = self.viewModel.item(at: indexPath.row)

		switch(optionItem.identifier) {
		case .populate:
			self.viewModel.initData()
		case .reset:
			self.viewModel.resetData()
		}

		self.dese
	}

	override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return nil
	}
}
