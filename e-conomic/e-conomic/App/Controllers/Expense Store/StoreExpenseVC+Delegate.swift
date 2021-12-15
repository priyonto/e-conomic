//
//  StoreExpenseVC+Delegate.swift
//  e-conomic
//
//  Created by iPriyo on 15/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import Foundation

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
