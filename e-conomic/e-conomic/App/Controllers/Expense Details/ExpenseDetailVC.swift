//
//  ExpenseDetailVC.swift
//  e-conomic
//
//  Created by iPriyo on 13/12/21.
//  Copyright © 2021 Priyoneer. All rights reserved.
//

import UIKit

class ExpenseDetailsVC: UIViewController {
    
    // MARK:- VARIABLES
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK:- SETUP UI
extension ExpenseDetailsVC {
    fileprivate func setupUI() {
        title = "Expense Details"
        view.backgroundColor = .systemBackground
    }
}
