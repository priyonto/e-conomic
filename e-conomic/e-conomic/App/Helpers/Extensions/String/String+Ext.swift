//
//  String+Ext.swift
//  e-conomic
//
//  Created by iPriyo on 14/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import Foundation


extension Optional where Wrapped == String {
    var nullOrEmpty: Bool {
        return (self == nil) || ((self?.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty) == nil) || (self == "")
    }
}

extension Optional where Wrapped == String {
    var int64Value:  Int64? {
        return Int64(self ?? "")
    }
    
    var doubleValue:  Double? {
        return Double(self ?? "")
    }
}

