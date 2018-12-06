//
//  Game.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 06.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation

struct PhotoItem {

	let name: String
	let order: Int
}

class Game {

	var name: String
	var player: String
	var photos: [PhotoItem]
	var score: Int

	init(name: String, player: String) {
		self.name = name
		self.player = player
		self.photos = []
		self.score = 0
	}
}
