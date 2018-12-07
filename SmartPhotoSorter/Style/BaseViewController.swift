//
//  BaseViewController.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 07.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, ThemeAware {

	var identifier: String = ""

	// MARK: - View loading

	override func viewDidLoad() {
		super.viewDidLoad()

		self.identifier = "\(self.hash)"
		ThemeManager.add(awareViewcontroller: self)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		handleThemeChanged()
	}

	deinit {
		ThemeManager.remove(awareViewcontroller: self)
	}

	// MARK: - Theme

	func handleThemeChanged() {

		let theme = ThemeManager.currentTheme()

		self.view.backgroundColor = theme.backgroundColor
		self.navigationController?.navigationBar.barStyle = theme.barStyle
	}
}
