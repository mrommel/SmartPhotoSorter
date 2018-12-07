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

class OptionsViewModel {

	var optionsItems: [OptionsItem] = []

	init() {
		self.optionsItems.append(OptionsItem(title: "Populate", image: R.image.populate()!, identifier: .populate))
		self.optionsItems.append(OptionsItem(title: "Reset", image: R.image.trash()!, identifier: .reset))
		self.optionsItems.append(OptionsItem(title: "Light", image: R.image.light()!, identifier: .light))
		self.optionsItems.append(OptionsItem(title: "Dark", image: R.image.dark()!, identifier: .dark))
	}

	func item(at index: Int) -> OptionsItem {
		return self.optionsItems[index]
	}

	func resetData() {

		let provider = GameProvider()
		provider.reset()
	}

	func initData() {

		let provider = GameProvider()
		provider.initData()
	}

	func switchDark() {

		ThemeManager.applyTheme(theme: .dark)
	}

	func switchLight() {

		ThemeManager.applyTheme(theme: .light)
	}
}
