//
//  StoreExpenseVC+Delegate.swift
//  e-conomic
//
//  Created by iPriyo on 15/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import Foundation
import UIKit

// MARK: - GenericSelectionDelegate
/// The class conforms to the protocol to process the value selected on the GenericSelectionVC screen
/// and render/store in this controller
extension StoreExpenseVC: GenericSelectionDelegate {
    func didSelectItem(item: Any) {
        if let item = item as? Category {
            categoryTextField.text = item.name
            selectedCategory = item
        } else if let item = item as? Currency {
            currencyTextField.text = "\(item.name) - \(item.symbol)"
            selectedCurrency = item
        } else {
            // something out of the context
        }
    }
}

// MARK: - UITextFieldDelegate
/// This is simple hack ofnot allowing user to type on the currency or category textfield
/// As those fields are used as selection component which takes user to a separate screen
/// This can be improved with custom label/button + UIView implementation
extension StoreExpenseVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == currencyTextField || textField == categoryTextField {
            return false
        }
        else {return true}
    }
}
