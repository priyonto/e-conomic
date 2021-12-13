//
//  UIViewController+Ext.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import UIKit

extension UIViewController {

    func navigateToExpenseDetailsScreen() {
        let controller = ExpenseDetailsVC()
        navigationController?.pushViewController(controller, animated: true)
    }
}