//
//  UITableViewCell+ScoreItem.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 12.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit
import Rswift

extension UITableViewCell {

	func set(scoreItem: ScoreItem?) {
		self.imageView?.image = R.image.score()

		if let scoreItem = scoreItem {
			self.textLabel?.text = "\(scoreItem.player) - \(scoreItem.score)%"
			self.detailTextLabel?.text = "\(scoreItem.date!)"
		} else {
			self.textLabel?.text = "No one - 0%"
			self.detailTextLabel?.text = "never"
		}
	}
}
