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

	var viewModel: ScoresViewModel? = nil

	override func viewDidLoad() {
		super.viewDidLoad()

		self.viewModel = ScoresViewModel()

		self.tableView.register(TableHeaderWithImage.self, forHeaderFooterViewReuseIdentifier: TableHeaderWithImage.reuseIdentifer)
		self.tableView.register(TableSectionHeader.self, forHeaderFooterViewReuseIdentifier: TableSectionHeader.reuseIdentifer)

		self.title = "Scores"
	}
}

// MARK: UITableViewDataSource

extension ScoresViewController {

	override func numberOfSections(in tableView: UITableView) -> Int {
		return self.viewModel?.scoreGameItemCount ?? 0
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel?.scoreItemCount(for: section) ?? 0
	}
}

// MARK: UITableViewDelegate

extension ScoresViewController {

	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

		let title = self.viewModel?.sectionTitle(at: section)

		if section == 0 {
			guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableHeaderWithImage.reuseIdentifer) as? TableHeaderWithImage else {
				return nil
			}

			header.label.text = title
			header.imageView.image = R.image.score()

			return header
		} else {
			guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableSectionHeader.reuseIdentifer) as? TableSectionHeader else {
				return nil
			}

			header.label.text = title

			return header
		}
	}

	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

		if section == 0 {
			return 180 + 52
		} else {
			return 52
		}
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath)
		if let scoreItem = self.viewModel?.scoreItem(at: indexPath) {
			cell.set(scoreItem: scoreItem)
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
