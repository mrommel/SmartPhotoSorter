//
//  OptionsHeader.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 09.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit

class OptionsHeader: ThemeAwareHeaderFooterView {

	static let reuseIdentifer = "OptionsHeaderReuseIdentifier"
	let label = ThemeAwareLabel.init()
	let imageView = UIImageView.init()

	override public init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)

		label.font = UIFont.preferredFont(forTextStyle: .largeTitle)

		label.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.addSubview(label)

		let margins = contentView.layoutMarginsGuide
		label.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
		label.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
		label.topAnchor.constraint(equalTo: margins.topAnchor, constant: 180).isActive = true
		label.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true

		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		self.contentView.addSubview(imageView)

		imageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
		imageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
		imageView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
		imageView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -52).isActive = true

	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
