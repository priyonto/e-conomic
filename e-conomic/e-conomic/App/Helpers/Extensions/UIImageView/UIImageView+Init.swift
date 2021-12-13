//
//  UIImageView+Init.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import UIKit


extension UIImageView {
    
    convenience init(image: UIImage? = nil, backgroundColor: UIColor = .clear, contentMode: ContentMode = .scaleAspectFit, cornerRadius: CGFloat = 0) {
        self.init()
        self.image = image
        self.backgroundColor = backgroundColor
        self.contentMode = contentMode
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.isAccessibilityElement = false
    }
    
}

