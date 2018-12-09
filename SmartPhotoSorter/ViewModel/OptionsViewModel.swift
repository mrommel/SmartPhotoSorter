//
//  OptionsViewModel.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 07.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit
import Rswift

enum OptionsType {
	case populate
	case reset
	case light
	case dark
}

struct OptionsItem {
	let title: String
	let image: UIImage
	let identifier: OptionsType
}

class OptionsSection {

	let title: String
	var items: [OptionsItem] = []

	init(title: String) {

		self.title = title
	}
}

class OptionsViewModel {

	var optionsSections: [OptionsSection] = []

	init() {

		let sectionData = OptionsSection(title: "Data")
		sectionData.items.append(OptionsItem(title: R.string.localizable.optionsItemPopulate(), image: R.image.populate()!, identifier: .populate))
		sectionData.items.append(OptionsItem(title: R.string.localizable.optionsItemReset(), image: R.image.trash()!, identifier: .reset))
		self.optionsSections.append(sectionData)

		let sectionTheme = OptionsSection(title: "Theme")
		sectionTheme.items.append(OptionsItem(title: R.string.localizable.optionsItemLight(), image: R.image.light()!, identifier: .light))
		sectionTheme.items.append(OptionsItem(title: R.string.localizable.optionsItemDark(), image: R.image.dark()!, identifier: .dark))
		self.optionsSections.append(sectionTheme)
	}

	var sectionCount: Int {
		return self.optionsSections.count
	}

	func sectionTitle(at index: Int) -> String {

		let section = self.optionsSections[index]

		return section.title
	}

	func rowsIn(section: Int) -> Int {

		let section = self.optionsSections[section]

		return section.items.count
	}

	func item(at indexPath: IndexPath) -> OptionsItem {

		let section = self.optionsSections[indexPath.section]

		return section.items[indexPath.row]
	}

	func handle(identifier: OptionsType) {

		switch(identifier) {
		case .populate:
			self.initData()
		case .reset:
			self.resetData()
		case .light:
			self.switchLight()
		case .dark:
			self.switchDark()
		}
	}

	private func resetData() {

		let provider = GameProvider()
		provider.reset()
	}

	private func initData() {

		let provider = GameProvider()
		provider.initData()
	}

	private func switchDark() {

		ThemeManager.applyTheme(theme: .dark)
	}

	private func switchLight() {

		ThemeManager.applyTheme(theme: .light)
	}
}
