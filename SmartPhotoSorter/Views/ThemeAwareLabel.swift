//
//  ThemeAwareLabel.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 09.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit

class ThemeAwareLabel: UILabel {

	var identifier: String = ""

	public override init(frame: CGRect) {

		super.init(frame: frame)

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

extension ThemeAwareLabel: ThemeAware {
	
	func handleThemeChanged() {

		let theme = ThemeManager.currentTheme()

		self.textColor = theme.titleTextColor
		//self.backgroundColor = UIColo
	}
}
