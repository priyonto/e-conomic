//
//  UIFont+Ext.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import UIKit

public extension UIFont {

    enum FontStyles: String {
        case regular = "Regular"
        case thin = "Thin"
        case ultraLight = "UltraLight"
        case light = "Light"
        case medium = "Medium"
        case semiBold = "SemiBold"
        case bold = "Bold"
    }
    
    // MARK:- FUNCTIONS
    static func AppleSDGothicNeo(_ type: FontStyles = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "AppleSDGothicNeo-\(type.rawValue)", size: size)!
    }
}
