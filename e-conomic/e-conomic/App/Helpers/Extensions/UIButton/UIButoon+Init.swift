//
//  UIButoon+Init.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import UIKit


extension UIButton {
    
    convenience init(backgroundColor: UIColor = .clear,
                     title: String? = "",
                     image: UIImage? = nil,
                     titleColor: UIColor = .clear,
                     font: UIFont = .AppleSDGothicNeo(.medium, size: 16), borderWidth: CGFloat = 0, borderColor: UIColor = .clear, cornerRadius: CGFloat = 0) {
        self.init()
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.setTitle(title, for: .highlighted)
        self.setTitleColor(titleColor, for: .normal)
        self.setTitleColor(titleColor, for: .highlighted)
        self.setImage(image, for: .normal)
        self.setImage(image, for: .highlighted)
        self.titleLabel?.font = font
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.clipsToBounds = true
    }
    
}

