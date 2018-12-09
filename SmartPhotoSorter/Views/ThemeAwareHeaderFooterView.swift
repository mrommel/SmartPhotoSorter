//
//  ThemeAwareHeaderFooterView.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 09.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit

class ThemeAwareHeaderFooterView: UITableViewHeaderFooterView {

	var identifier: String = ""

	public override init(reuseIdentifier: String?) {

		super.init(reuseIdentifier: reuseIdentifier)

		self.identifier = "\(self.hash)"
		ThemeManager.add(awareViewcontroller: self)

		self.handleThemeChanged()
	}

	public required init?(coder aDecoder: NSCoder) {

		super.init(coder: aDecoder)

		self.identifier = "\(self.hash)"
		ThemeManager.add(awareViewcontroller: self)

		self.handleThemeChanged()
	}

	deinit {
		ThemeManager.remove(awareViewcontroller: self)
	}
}

extension ThemeAwareHeaderFooterView: ThemeAware {

	func handleThemeChanged() {

		let theme = ThemeManager.currentTheme()

		self.contentView.backgroundColor = theme.backgroundColor
	}
}
