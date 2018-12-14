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
			return UIColor.chelseaCucumber
		case .dark:
			return UIColor.cinnabar
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
			return UIColor.white
		case .dark:
			return UIColor.darkGray
		}
	}

	var titleTextColor: UIColor {
		switch self {
		case .light:
			return UIColor.darkGray
		case .dark:
			return UIColor.white
		}
	}

	var subtitleTextColor: UIColor {
		switch self {
		case .light:
			return UIColor.darkGray
		case .dark:
			return UIColor.white
		}
	}
}
