//
//  GameViewModel.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 06.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

class GameViewModel {

	let name: String

	init(name: String) {
		self.name = name
	}

	func amountOfImages() -> Int {
		return 10
	}

	func score() -> Int {
		return 10
	}
}
