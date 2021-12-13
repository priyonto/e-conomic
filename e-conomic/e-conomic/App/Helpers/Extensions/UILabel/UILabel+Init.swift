//
//  UILabel+Init.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, textColor: UIColor = .label, font: UIFont = .AppleSDGothicNeo(.regular, size: 16), numberOfLines: Int = 0, alignment: NSTextAlignment = .left) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.font = font
        self.numberOfLines = numberOfLines
        self.textAlignment = alignment
    }
    
}
