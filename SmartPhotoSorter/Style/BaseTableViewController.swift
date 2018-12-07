//
//  BaseTableViewController.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 07.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation
import UIKit

class BaseTableViewController : UITableViewController, ThemeAware {

	var identifier: String = ""

	// MARK: - View loading

	override func viewDidLoad() {
		super.viewDidLoad()
		self.clearsSelectionOnViewWillAppear = false

		self.identifier = "\(self.hash)"
		ThemeManager.add(awareViewcontroller: self)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		self.handleThemeChanged()
	}

	deinit {
		ThemeManager.remove(awareViewcontroller: self)
	}

	// MARK: - Theme

	func handleThemeChanged() {

		let theme = ThemeManager.currentTheme()

		self.view.backgroundColor = theme.backgroundColor
		self.tableView.backgroundColor = theme.backgroundColor
		self.navigationController?.navigationBar.barStyle = theme.barStyle
		self.navigationController?.view.backgroundColor = theme.backgroundColor

		self.tableView.reloadData()
	}

	// MARK: - Table view data source

	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

		let theme = ThemeManager.currentTheme()

		cell.textLabel?.textColor = theme.titleTextColor
		cell.detailTextLabel?.textColor = theme.subtitleTextColor
		cell.backgroundColor = theme.backgroundColor
	}
}
