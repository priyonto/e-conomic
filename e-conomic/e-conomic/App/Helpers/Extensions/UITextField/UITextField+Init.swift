//
//  UITextField+Init.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import UIKit


extension UITextField {
    
    convenience init(keyboardType: UIKeyboardType = .default, placeHolder: String = "", placeHolderColor: UIColor = UIColor.label.withAlphaComponent(0.32), textColor: UIColor = .label, isSecured: Bool = false, font: UIFont = .AppleSDGothicNeo(.regular, size: 16)) {
        self.init()
        
        self.tintColor = .black
        self.keyboardType = keyboardType
        self.textColor = textColor
        self.isSecureTextEntry = isSecured
        self.font = font
        self.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes:[NSAttributedString.Key.foregroundColor: placeHolderColor])
        self.tintColor = .label // For cursor color
        self.layer.borderColor = UIColor.label.cgColor
        self.layer.borderWidth = 0.15
        self.layer.cornerRadius = 6
        self.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0); // For padding
    }
}
