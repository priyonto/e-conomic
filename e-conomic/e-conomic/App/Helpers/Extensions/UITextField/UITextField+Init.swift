//
//  UITextField+Init.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import UIKit


extension UITextField {
    
    convenience init(keyboardType: UIKeyboardType = .default, placeHolder: String = "", placeHolderColor: UIColor = UIColor.black.withAlphaComponent(0.32), textColor: UIColor = .black, isSecured: Bool = false, font: UIFont = .AppleSDGothicNeo(.regular, size: 16)) {
        self.init()
        
        self.tintColor = .black
        self.keyboardType = keyboardType
        self.textColor = textColor
        self.isSecureTextEntry = isSecured
        self.font = font
        self.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes:[NSAttributedString.Key.foregroundColor: placeHolderColor])
        self.accessibilityLabel = placeHolder
    }
}
