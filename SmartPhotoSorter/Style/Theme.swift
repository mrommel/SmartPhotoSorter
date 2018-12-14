//
//  Theme.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 07.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit

enum Theme: Int {

	case light, dark

	var mainColor: UIColor {
		switch self {
		case .light:
			return UIColor().colorFromHexString("#8DBA77")
		case .dark:
			return UIColor().colorFromHexString("#E35740")
		}
	}

	// Customizing the Navigation Bar
	var barStyle: UIBarStyle {
		switch self {
		case .light:
			return .default
		case .dark:
			return .black
		}
	}

	var navigationBackgroundImage: UIImage? {
		return self == .light ? UIImage(named: "navBackground") : nil
	}

	var tabBarBackgroundImage: UIImage? {
		return self == .light ? UIImage(named: "tabBarBackground") : nil
	}

	var backgroundColor: UIColor {
		switch self {
		case .light:
			return UIColor().colorFromHexString("#ffffff")
		case .dark:
			return UIColor().colorFromHexString("#363636")
		}
	}

	var titleTextColor: UIColor {
		switch self {
		case .light:
			return UIColor().colorFromHexString("#363636")
		case .dark:
			return UIColor().colorFromHexString("#ffffff")
		}
	}

	var subtitleTextColor: UIColor {
		switch self {
		case .light:
			return UIColor().colorFromHexString("#363636")
		case .dark:
			return UIColor().colorFromHexString("#ffffff")
		}
	}
}
