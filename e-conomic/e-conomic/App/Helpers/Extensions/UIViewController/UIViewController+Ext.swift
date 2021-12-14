//
//  UIViewController+Ext.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import UIKit

extension UIViewController {

    func navigateToExpenseDetailsScreen(_ expense: Expense) {
        let controller = ExpenseDetailsVC(expense)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func presentStoreExpenseScreen(_ image: UIImage) {
        let controller = StoreExpenseVC(image)
        let navigationController = UINavigationController(rootViewController: controller)
        present(navigationController, animated: true, completion: nil)
    }
    
    
    func navigateToGenericSelectionScreen(_ selectionState: SelectionState, delegate: GenericSelectionDelegate) {
        let controller = GenericSelectionVC(selectionState: selectionState, delegate: delegate)
        navigationController?.pushViewController(controller, animated: true)
    }
}
