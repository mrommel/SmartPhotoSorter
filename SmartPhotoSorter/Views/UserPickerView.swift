//
//  UserPickerView.swift
//  SmartPhotoSorter
//
//  Created by Michael Rommel on 14.12.18.
//  Copyright © 2018 Michael Rommel. All rights reserved.
//

import UIKit

class UserPickerView: UIView {
    
    var imageView: UIImageView?
    var labelView: UILabel?
    
    var username: String? = nil {
        didSet {
            self.labelView?.text = self.username
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 5), size: CGSize(width: 32, height: 32)))
        self.imageView?.image = R.image.user()
        
        self.labelView = UILabel(frame: CGRect(origin: CGPoint(x: 40, y: 5), size: CGSize(width: 120, height: 32)))
        
        self.addSubview(self.imageView!)
        self.addSubview(self.labelView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
