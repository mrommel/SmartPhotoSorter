//
//  MainViewModel.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 08.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit

private enum Constants {
	static let showGames = "showGames"
	static let showScores = "showScores"
	static let showOptions = "showOptions"
}

struct MenuItem {
	let title: String
	let image: UIImage?
	let segue: String?
}

class MainViewModel {

	var menuItems: [MenuItem] = []

	init() {
		self.menuItems.append(MenuItem(title: R.string.localizable.mainMenuGames(), image: R.image.rocket(), segue: Constants.showGames))
		self.menuItems.append(MenuItem(title: R.string.localizable.mainMenuScores(), image: R.image.score(), segue: Constants.showScores))
		self.menuItems.append(MenuItem(title: R.string.localizable.mainMenuOptions(), image: R.image.options(), segue: Constants.showOptions))
	}

	var menuItemsCount: Int {
		return self.menuItems.count
	}

	func menuItem(at index: Int) -> MenuItem {
		return self.menuItems[index]
	}
}
