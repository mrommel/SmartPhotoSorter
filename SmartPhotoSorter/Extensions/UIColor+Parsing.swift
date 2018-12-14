//
//  UIColor+Parsing.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 07.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit

extension UIColor {

	convenience init(hex: String) {

		var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

		if (cString.hasPrefix("#")) {
			cString.remove(at: cString.startIndex)
		}

		if (cString.count != 6) {
			self.init()
            return
		}

		var rgbValue: UInt32 = 0
		Scanner(string: cString).scanHexInt32(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        let alpha = CGFloat(1.0)
		
        self.init(red: red, green: green, blue: blue, alpha: alpha)
	}
}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}
