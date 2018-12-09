//
//  OptionsSectionHeader.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 09.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit

class OptionsSectionHeader: ThemeAwareHeaderFooterView {

	static let reuseIdentifer = "OptionsSectionHeaderReuseIdentifier"
	let label = ThemeAwareLabel.init()

	override public init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)

		label.font = UIFont.preferredFont(forTextStyle: .largeTitle)

		label.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.addSubview(label)

		let margins = contentView.layoutMarginsGuide
		label.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
		label.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
		label.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
		label.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
