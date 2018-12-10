//
//  OptionsViewController.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 07.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit
import Rswift

protocol OptionsViewControllerProtocol {

	func showDataPopulateWarningAlert()
	func showDataResetWarningAlert()
}

class OptionsViewController: BaseTableViewController {

	var viewModel: OptionsViewModel? = nil

	override func viewDidLoad() {
		super.viewDidLoad()

		self.viewModel = OptionsViewModel(viewController: self)

		self.tableView.register(OptionsHeader.self, forHeaderFooterViewReuseIdentifier: OptionsHeader.reuseIdentifer)
		self.tableView.register(OptionsSectionHeader.self, forHeaderFooterViewReuseIdentifier: OptionsSectionHeader.reuseIdentifer)

		self.title = R.string.localizable.optionsTitle()
	}

}

// MARK: - OptionsViewControllerProtocol

extension OptionsViewController: OptionsViewControllerProtocol {

	func showDataResetWarningAlert() {

		let alert = UIAlertController(title: "Warning",
									  message: "Are you really sure to delete the data in the database?",
									  preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in

			self.viewModel?.executeReset()
		}))
		alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

		self.present(alert, animated: true)
	}

	func showDataPopulateWarningAlert() {

		let alert = UIAlertController(title: "Warning",
									  message: "There is already data in the database. Are you sure that you want to insert new data on top?",
									  preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in

			self.viewModel?.executePopulate()
		}))
		alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

		self.present(alert, animated: true)
	}


}

// MARK: - UITableViewDataSource

extension OptionsViewController {

	override func numberOfSections(in tableView: UITableView) -> Int {
		return self.viewModel?.sectionCount ?? 0
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel?.rowsIn(section: section) ?? 0
	}
}

// MARK: - UITableViewDelegate

extension OptionsViewController {

	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

		let title = self.viewModel?.sectionTitle(at: section)

		if section == 0 {
			guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: OptionsHeader.reuseIdentifer) as? OptionsHeader else {
				return nil
			}

			header.label.text = title
			header.imageView.image = R.image.options()

			return header
		} else {
			guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: OptionsSectionHeader.reuseIdentifer) as? OptionsSectionHeader else {
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
		let optionItem = self.viewModel?.item(at: indexPath)

		cell.imageView?.image = optionItem?.image
		cell.textLabel?.text = optionItem?.title

		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		let optionItem = self.viewModel?.item(at: indexPath)

		self.viewModel?.handle(identifier: optionItem?.identifier ?? .none)

		self.tableView.deselectRow(at: indexPath, animated: true)
	}
}
