//
//  ThemeManager.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 07.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit
import Foundation

protocol ThemeAware: class {

	var identifier: String { get set }
	func handleThemeChanged()
}

// Enum declaration
let SelectedThemeKey = "SelectedTheme"

// This will let you use a theme in the app.
class ThemeManager {

	private static var awareViewControllers: [ThemeAware] = []

	static func add(awareViewcontroller: ThemeAware) {
		awareViewControllers.append(awareViewcontroller)
	}

	static func remove(awareViewcontroller: ThemeAware) {

		if let index = awareViewControllers.index(where: { $0.identifier == awareViewcontroller.identifier }) {
			awareViewControllers.remove(at: index)
		}
	}

	// ThemeManager
	static func currentTheme() -> Theme {
		if let storedTheme = (UserDefaults.standard.value(forKey: SelectedThemeKey) as AnyObject).integerValue {
			return Theme(rawValue: storedTheme)!
		} else {
			return .dark
		}
	}

	static func applyTheme(theme: Theme) {
		// First persist the selected theme using NSUserDefaults.
		UserDefaults.standard.setValue(theme.rawValue, forKey: SelectedThemeKey)
		UserDefaults.standard.synchronize()

		// You get your current (selected) theme and apply the main color to the tintColor property of your application’s window.
		let sharedApplication = UIApplication.shared
		sharedApplication.delegate?.window??.tintColor = theme.mainColor

		UINavigationBar.appearance().barStyle = theme.barStyle
		UINavigationBar.appearance().setBackgroundImage(theme.navigationBackgroundImage, for: .default)
		UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backArrow")
		UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "backArrowMaskFixed")

		UITabBar.appearance().barStyle = theme.barStyle
		UITabBar.appearance().backgroundImage = theme.tabBarBackgroundImage

		let tabIndicator = UIImage(named: "tabBarSelectionIndicator")?.withRenderingMode(.alwaysTemplate)
		let tabResizableIndicator = tabIndicator?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 2.0, bottom: 0, right: 2.0))
		UITabBar.appearance().selectionIndicatorImage = tabResizableIndicator

		let controlBackground = UIImage(named: "controlBackground")?.withRenderingMode(.alwaysTemplate)
			.resizableImage(withCapInsets: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
		let controlSelectedBackground = UIImage(named: "controlSelectedBackground")?
			.withRenderingMode(.alwaysTemplate)
			.resizableImage(withCapInsets: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))

		UISegmentedControl.appearance().setBackgroundImage(controlBackground, for: .normal, barMetrics: .default)
		UISegmentedControl.appearance().setBackgroundImage(controlSelectedBackground, for: .selected, barMetrics: .default)

		UIStepper.appearance().setBackgroundImage(controlBackground, for: .normal)
		UIStepper.appearance().setBackgroundImage(controlBackground, for: .disabled)
		UIStepper.appearance().setBackgroundImage(controlBackground, for: .highlighted)
		UIStepper.appearance().setDecrementImage(UIImage(named: "fewerPaws"), for: .normal)
		UIStepper.appearance().setIncrementImage(UIImage(named: "morePaws"), for: .normal)

		UISlider.appearance().setThumbImage(UIImage(named: "sliderThumb"), for: .normal)
		UISlider.appearance().setMaximumTrackImage(UIImage(named: "maximumTrack")?
			.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0.0, bottom: 0, right: 6.0)), for: .normal)
		UISlider.appearance().setMinimumTrackImage(UIImage(named: "minimumTrack")?
			.withRenderingMode(.alwaysTemplate)
			.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 6.0, bottom: 0, right: 0)), for: .normal)

		UISwitch.appearance().onTintColor = theme.mainColor.withAlphaComponent(0.3)
		UISwitch.appearance().thumbTintColor = theme.mainColor

		// notify theme aware view controllers
		for awareViewController in awareViewControllers {
			awareViewController.handleThemeChanged()
		}
	}
}
