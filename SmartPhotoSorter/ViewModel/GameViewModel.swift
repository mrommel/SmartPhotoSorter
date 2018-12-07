//
//  GameViewModel.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 06.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import Foundation
import SKPhotoBrowser

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

	func createLocalPhotos() -> [SKPhotoProtocol] {

		let amountOfImages = self.amountOfImages()

		return (0..<amountOfImages).map { (i: Int) -> SKPhotoProtocol in
			let photo = SKPhoto.photoWithImage(UIImage(named: "image\(i%10)")!)
			photo.caption = R.string.localizable.gameDetailCaption()
			return photo
		}
	}

	func createLocalOrder() -> [Int] {

		let amountOfImages = self.amountOfImages()

		return (0..<amountOfImages).map{ (i: Int) -> Int in
			return i
		}
	}
}
