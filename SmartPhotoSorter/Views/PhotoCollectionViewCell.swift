//
//  PhotoCollectionViewCell.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 07.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var photoImageView: UIImageView!

	override func awakeFromNib() {
		super.awakeFromNib()

		self.photoImageView.image = nil
		layer.cornerRadius = 25.0
		layer.masksToBounds = true
	}

	override func prepareForReuse() {
		self.photoImageView.image = nil
	}
}
