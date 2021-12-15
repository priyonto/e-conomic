//
//  UIViewController+Ext.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import UIKit

// MARK: - Routing
/// Ideally a UIViewController extension is utilized to navigate to or present different screens
/// For a small application like this where a lot of independent screens are not available implementing router or coordinator seems overkill and would produce a lot of boilerplate codes
///
extension UIViewController {

    /// Navigates to the ExpenseDetailsScreen, required passing an argument of type Expense
    /// Without an expense object the screen can not be instantiated
    func navigateToExpenseDetailsScreen(_ expense: Expense) {
        let controller = ExpenseDetailsVC(expense)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    /// Presents expense store screen, required passing an argument of type UIImage
    /// Without an UIImage object the screen can not be instantiated
    func presentStoreExpenseScreen(_ image: UIImage) {
        let controller = StoreExpenseVC(image)
        let navigationController = UINavigationController(rootViewController: controller)
        present(navigationController, animated: true, completion: nil)
    }
    
    /// Navigates to the GenericSelectionScreen from where currencies or categories can be selected
    /// This method takes two argument; SelectionState and reference of GenericSelectionDelegate
    func navigateToGenericSelectionScreen(_ selectionState: SelectionState, delegate: GenericSelectionDelegate) {
        let controller = GenericSelectionVC(selectionState: selectionState, delegate: delegate)
        navigationController?.pushViewController(controller, animated: true)
    }
}
