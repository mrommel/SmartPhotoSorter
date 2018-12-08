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
		self.optionsItems.append(OptionsItem(title: R.string.localizable.optionsItemPopulate(), image: R.image.populate()!, identifier: .populate))
		self.optionsItems.append(OptionsItem(title: R.string.localizable.optionsItemReset(), image: R.image.trash()!, identifier: .reset))
		self.optionsItems.append(OptionsItem(title: R.string.localizable.optionsItemLight(), image: R.image.light()!, identifier: .light))
		self.optionsItems.append(OptionsItem(title: R.string.localizable.optionsItemDark(), image: R.image.dark()!, identifier: .dark))
	}

	func item(at index: Int) -> OptionsItem {
		return self.optionsItems[index]
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
